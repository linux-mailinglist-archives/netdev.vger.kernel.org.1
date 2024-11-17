Return-Path: <netdev+bounces-145642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A024B9D0417
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3BB2580B
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D6126C09;
	Sun, 17 Nov 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFLmPBAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDAF1E4AB;
	Sun, 17 Nov 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850313; cv=none; b=R19MzWlSKJ/lI+sCdG1G2DQJLrLgd5Nv8Q6pA5llb9YXv51E/XsOD2Pw5fjH+Z3Iw/P99UPHmTlIw3ujpMrfFgJmwkH+QuD2mMcxjWcLms5WHpeqE+dJV07TcbFa/CMll64LXbU73pquE+HYAueZG0Xho2rXKn99/pdvoPudzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850313; c=relaxed/simple;
	bh=98BfMBAt1C0W4NJ4jKkYuWlULsYMUPHaFx7a6fdmLcc=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLy5S3lll9PGBGi/G6I8906Zu+6rtl0aF2ehhtwOfB2Zy0bym1tbI8+y0ACX1nXw1PQYeQHAX6W6cQ1ZaOQeWz0lXTTqcq6xcCFUscTZOlHvQUUfzFoakyerbPXrDwKwOriXP5bYG/6fA6DpYVAUxIUBpSFLeWe9pkUjFxGA/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFLmPBAa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eac969aso18370235e9.1;
        Sun, 17 Nov 2024 05:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731850310; x=1732455110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FnDq/5jDtvRz9wvJUkiQLKbNnaCYIlhSUV3JJFbTe6Y=;
        b=QFLmPBAadlj0nV5mybdd52Nk+6RalwHuddtULPRcHdZvmexGtqRIpzDtXNcANlwxdW
         ZeuooUrzqBB77CCVzW5AVRSG3LIo7B69gmmcXyJBhjIZjA/LlC7K3FF8/kfZ7vlJv0kC
         yuVCvPUMqOwBohVULg9IoK0oQNWnB9wO3x784lM9zHysTranbDnzjReY+tli6lcA2L7i
         4x808XDZMqnCVx5O18n9hoNjmTPK0k5iz5BaJimfAyFfuB97g2EFdrRBoQKsOEtnilpT
         4RBpgSADxB3x190nluUX5aoXo/SQrV3AZVMRYfyi7neEHx9hi/FDl8agDTPeFkfgLyX5
         Nbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731850310; x=1732455110;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnDq/5jDtvRz9wvJUkiQLKbNnaCYIlhSUV3JJFbTe6Y=;
        b=j7fbUtA7Cwx0kzbacHhrR7jNoI3CDDk0zPoER7oMjJAQufDnzAdwO0WI5Iwcb5+fsJ
         SV/OMgSFbF/xBhimZHcVy5uT5osCAbihBgNl+Z76iAEG84me6obkVWS30jBfVYW6itxF
         Tm0ghE0N/BlYegOD3wRpD4wKbn8u3ARXXE1CQcAAVvtABgt4jYPmpJ0x3mXvuFWzlqa5
         YUzQMt7J/h7KKTVxirNaH2V6agJL4R+4TILH1t8DqfU2nbo6e22P9LZLnZzSgiaotrfX
         BDoSNRFt5EABTQI5JEFcZBjUIeCb3sWZDG0hVni5j3cpf1i0jm5jB4jSA7dPXvkXGhfD
         Sv3A==
X-Forwarded-Encrypted: i=1; AJvYcCU8EzzhsrNRqj9NvYNT9wMllGicF+WEj0w3pqAsp0CpcGDgB+HeE5Bdu00LC1YQeTE9CQn6p2+sur37qXbO@vger.kernel.org, AJvYcCVyRSP8q15hHoYwVPEuKTKX2zPe72unrcFEP8i6+vfrZi2DkXeosjCmjkdEiYWB81msh0DmRpYX@vger.kernel.org, AJvYcCXs4FXmKnV9xcDrK2L8PaKoj9sWaH3mvdNHp9+lGmUDHy9vAiybSvy3kzyZgVtEtReHGHWF9mkcvae4@vger.kernel.org
X-Gm-Message-State: AOJu0YxXST/dO2JA4FB8LAiV/frrRi+Hy8myNCgfqA1zmmZxC8cKy+qq
	e2hNBeiFYAH/hmPlWzYpTzj5bux46IyFp1TesKMlHKZJL0lJ3Ja6
X-Google-Smtp-Source: AGHT+IERyxnbD4p7iEZ9MOnnFKigJwdLcKzUPk6eBLQKFq6MYktdFTsmEMmPRzYPWbmoKwroTD4JwQ==
X-Received: by 2002:a05:600c:548b:b0:42c:b54c:a6d7 with SMTP id 5b1f17b1804b1-432d9767d80mr126959115e9.14.1731850309608;
        Sun, 17 Nov 2024 05:31:49 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da29978dsm122010285e9.41.2024.11.17.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 05:31:49 -0800 (PST)
Message-ID: <6739f045.050a0220.3b85cd.5d42@mx.google.com>
X-Google-Original-Message-ID: <ZznwQRSsOT3CnD4v@Ansuel-XPS.>
Date: Sun, 17 Nov 2024 14:31:45 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v6 0/4] net: dsa: Add Airoha AN8855 support
References: <20241116131257.51249-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116131257.51249-1-ansuelsmth@gmail.com>

On Sat, Nov 16, 2024 at 02:12:45PM +0100, Christian Marangi wrote:
> This small series add the initial support for the Airoha AN8855 Switch.
> 
> It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.
> 
> This is starting to get in the wild and there are already some router
> having this switch chip.
> 
> It's conceptually similar to mediatek switch but register and bits
> are different. And there is that massive Hell that is the PCS
> configuration.
> Saddly for that part we have absolutely NO documentation currently.
> 
> There is this special thing where PHY needs to be calibrated with values
> from the switch efuse. (the thing have a whole cpu timer and MCU)
> 

Totally forgot to fix the devm_dsa_register_switch export symbol, fixed
in v7. Sorry!

-- 
	Ansuel

