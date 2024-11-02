Return-Path: <netdev+bounces-141180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A769B9D51
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 06:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF89D2865DE
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 05:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C21448E3;
	Sat,  2 Nov 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHZzgP7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147C2595;
	Sat,  2 Nov 2024 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730525648; cv=none; b=hMahDV8g/7CcHxX4UWgfIrX9Pmj1YHIIy6cZwaI4gMh1bdH0RWUis19ReXIdFyk3oq7eyvDwrmxs53yy8zspbor1E1koy5l3ZN5jE48K5fVWWW0FguGU6HivbIuSR1AO3mCZo8LokrsLdqs7VMPOoOeyekkL9rsZfi/4CzAjqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730525648; c=relaxed/simple;
	bh=7ZWq3c6xaRl+h6ragkZhBKlh/9oJe6LqL4h5CFwBSm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5k9QOBUO2ajQOVIrS2hRwMCR65gCjcW08JrUSPiuvPej6hLrMz2HMmT3Wvyo6sTmIqbSkmZZF9bjPiMLv622VZlox1eh+NrHQsZilyaIgAShPDGyogClB2Xh2jlvLPT3GtGPz5qXg6owSRR4TTSEN3CuQzegSN77T9jSLD3Ih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHZzgP7r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c714cd9c8so27879275ad.0;
        Fri, 01 Nov 2024 22:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730525646; x=1731130446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl0ZSjV2wwdG7v/jul86kkIeCsNbggoH1Vd4XqoR3yw=;
        b=nHZzgP7rI1VPJGWhCiV36tJBJNQnINDs7YkZC8ifKiGdsy3QIGCAkdjh3l1aJNAuba
         WrP9K/V7f7OV4OkNmXg463iYkHGDSiZ/vwzwme+i5JokmSVZoGYLeZsRl2m3oh4UwAMp
         3O2iDGm5Z5z7edDtUvPJeEQyCrgGnc5vEapDkh6I0hABkxOXbGZ0Psifv+WmlOWjxZ/5
         XabIdr+SBIBR0B0EBvDIBJzTAeAbfE7guzNFF6Q93JITPFnUJeIjMXiPAP3V6BTG/Wu6
         1SPz3AoCmjCJjR1oXq2G4xtg7NykVKc2MjtQGxL3ZPR+UgZcJqEYtdkHV5DjOOgKIvZ0
         0C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730525646; x=1731130446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl0ZSjV2wwdG7v/jul86kkIeCsNbggoH1Vd4XqoR3yw=;
        b=qVCY4JqPs1Hyb1NUJRLbFJBlzHS2xHNe5eo3tYQUItPEQWmwl9dD2j98chBPtzemN+
         upMgX6HMtPjvHbynHiE+CWKh9SbTh6zUqxqPivUXijfq6qb28N0IaQM0llDHlhAdhVAi
         EdIyTStyVUqUbQjlNDcE1BA6PqeidHdbWd1uqb3uBYF0L5at5GPpam5ef6cxFKecU0Uu
         SHJN0iwEvwNPmS+TkKHz6riEofSXmBptLYooS6T4C39FYknkNnZ3eP9/FtE59CUReQGb
         +GoNc0t03/qEyY0Q1apHN/hdRBKb+N4Qhh/qF4wzE2WmyNCcT9mUgxGQJAa1X/8rtYzb
         03kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz+6l6WATI1FUr/138fP4kzRoGfTC4DwsHNpm/inpTaA0Isu875MafNUbqeY1MQ95RR68hr3tBiGRatD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTyUKy/298vOS8eDVLOTjK0nQvCNWAo/ygS43V0PgbPT+Y0jq
	jbLNL39fl+Uj+qHHcMY+8GU1ktij+9CYWM09WJZVjAnBffCBMVux
X-Google-Smtp-Source: AGHT+IFSBLSRmWr+ADqlQojeA6O0wCRf+1EVr8y7UIwQWNNJ4vrlbCerMlqoHCiFATN78RepdHZAyA==
X-Received: by 2002:a17:902:ce85:b0:20c:a1a3:5373 with SMTP id d9443c01a7336-2111b01c640mr83003945ad.55.1730525646080;
        Fri, 01 Nov 2024 22:34:06 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a63f2sm28700365ad.168.2024.11.01.22.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 22:34:05 -0700 (PDT)
Date: Sat, 2 Nov 2024 13:33:54 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 andrew+netdev@lunn.ch, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com
Subject: Re: [PATCH net-next v8 0/8] net: stmmac: Refactor FPE as a separate
 module
Message-ID: <20241102133354.00002357@gmail.com>
In-Reply-To: <20241101142908.ohdxsokygout5mfs@skbuf>
References: <cover.1730449003.git.0x1207@gmail.com>
	<20241101142908.ohdxsokygout5mfs@skbuf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On Fri, 1 Nov 2024 16:29:08 +0200, Vladimir Oltean <olteanv@gmail.com> wrote:

> For the series:
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Much appreciated for your valuable comments on this series and also the
previous series that moves stmmac FPE over to the new standard
ethtool-mm/tc-mqprio/tc-taprio.
The FPE support on stmmac would never be so complete and so soon without your help.

Have a nice weekend :)

