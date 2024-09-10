Return-Path: <netdev+bounces-127041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7030C973CD9
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CC41C210F3
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ECC191F9B;
	Tue, 10 Sep 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEWmbdp2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94F39FC6;
	Tue, 10 Sep 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984093; cv=none; b=cKXJDCWgoQ68reA7DtCJhgzKsWG7Uo2u57laKeFVxDZ4dPtFao8Pyrp2nUVqzG0zmyRT7nSGX2RnjGAFqKSvuVqZs/uya9ISwfUfY9k1n0mKjZcaobKkDRs4usDn4XUZRzeQpkDpbQ6oOLkTtPc3zVfMbJsoTNiXZ5Cf1Q8+Xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984093; c=relaxed/simple;
	bh=bQGHXifPvsbvPWuC56UdeWwyp4NX1tMcgWqCK5MrAzc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R9662lGyXJ93xvD/MWM6rqt8LheMvFB1m1l+fZalGdmG4gA8ZT6OGrHWZGZmIXRrxeRFsJZo/HNtEyAqKCYhZILYQBcFX+UIJVwcM8tN4P9HIBmNNCnAcWnKECAKSl9BxXNp6J8SfNYPD3JEY+g5JLicWoJMVl0Pt5REv+TghJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEWmbdp2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so258734266b.1;
        Tue, 10 Sep 2024 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725984089; x=1726588889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iq8Oj4Jbe5mYStKQTQI9BBAsPuGQFpYytdqKPCBemf4=;
        b=mEWmbdp2jn59Fs1JiW5Hwn2n2KNlul0D3FatSGnyOKCioDW1HBcjD5zRNw//pFgJR3
         KD8yE5R1/mR+lEGn5nBzCavx9+OCnB7AKiNoTCDLqHQ+jV3xNvAJXsWxvh+w/MeEbBHd
         9L7ZbAigC256luLOMNxquSzZPzR686+hv2tSuwr5e57iw2zj9hDItoUXeMPTNvEDcQfo
         M+Q7FznlSkz8vyvE4F7ECNpYBkasqlMjsad0iX8ccD4FNxJ6ptmefBJ+QAQ5UyG0lrL/
         9VZBSybOL/knJGmDindpFTbcKJxIfU8CNDwYUpqe2N7NUBc/74n/JbQig/SeRAlSoHpR
         1ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984089; x=1726588889;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iq8Oj4Jbe5mYStKQTQI9BBAsPuGQFpYytdqKPCBemf4=;
        b=YgYjkrMEATVRSPsiL/iJGiDJr+T1zl6vW7uRQvpY8laIecyxEqawA07KffTTM7kBwb
         z+TjZ+cVey2okYhDzafcrapItMjscUJr5BjE4hl4wPID0W/J7tffxh7xdacGpuWdcDvS
         bMNP3wPLWlTyQNVYYAtPGrMeGZQoGKzSAfsndUhLEJlgZb9sQYwnOl+mFG0+YhmTT8m9
         XAeovAtme1uBPaxuxtfGtmv/dlcEN0q/geiywHkDoi9Rh49NBHfWW11yY0PWYuy1L2Db
         g60TsOM2Xbi68Gwdh0fr1TpPa6S5qiwYiBKRRSbPrpp0yhv7Ojhr3EzVK1HS5uejQ5uD
         oJOw==
X-Forwarded-Encrypted: i=1; AJvYcCXdqV+8jxHiaSnUhi5h1DO7gr6mw4ivxRSTCPtIMKitOzigRhrxODzuh+Dnqn/aD7Owpzy3Znc4IDIPjWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeugiFzMSWlUf2oX/Yj+nR/9xKyAC2mVFt9rPG6bpe196pUvF
	jEbNur5bcvLbdp528h91F6GkvW/cVRokdqbpXfMkzlQL12LH+z72zeknQw==
X-Google-Smtp-Source: AGHT+IH1i6mMvfMAluOnQ9KRvLaVI0J+4I4iDARNRNXsuptMIIYaCHsnwWfJqWL8It+B2/D0XNLJ8A==
X-Received: by 2002:a17:906:794f:b0:a86:91c3:9517 with SMTP id a640c23a62f3a-a8ffab70902mr126156166b.35.1725984088508;
        Tue, 10 Sep 2024 09:01:28 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d63bf7sm489078966b.218.2024.09.10.09.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 09:01:28 -0700 (PDT)
Subject: Re: [PATCH net-next] sfc: Add X4 PF support
To: jonathan.s.cooper@amd.com, Martin Habets <habetsm.xilinx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20240910153014.12803-1-jonathan.s.cooper@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ca7d4610-02f0-133e-ada9-975aa1585f0d@gmail.com>
Date: Tue, 10 Sep 2024 17:01:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240910153014.12803-1-jonathan.s.cooper@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 10/09/2024 16:30, jonathan.s.cooper@amd.com wrote:
> From: Jonathan Cooper <jonathan.s.cooper@amd.com>
> 
> Add X4 series. Most functionality is the same as previous
> EF10 nics but enough is different to warrant a new nic type struct
> and revision; for example legacy interrupts and SRIOV are
> not supported.
> 
> Most removed features will be re-added later as new implementations.
> 
> Signed-off-by: Jonathan Cooper <jonathan.s.cooper@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

