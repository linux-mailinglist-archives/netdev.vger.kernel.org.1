Return-Path: <netdev+bounces-160015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDBA17BB6
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75E51886660
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CBB1F0E5E;
	Tue, 21 Jan 2025 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QO7iuEmW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0861F0E51
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737455393; cv=none; b=uJH/VcPdzYq9rQj0DCZ9Rb1ne+iCFfvjcFam1WYYXcQj506XLHBDSYifl6J+ITHWqxg7Fr1M44leCgTcp/GIBQAGXm18VcT5xNuUu66Mf8AywDiGn5aj4tDrDYMx5rEQlMKrYNKAzMQO9f2Q4yL3PG8EYahoQRyjlKssbzTDEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737455393; c=relaxed/simple;
	bh=6AaEQjUILhJ/z5XoYOm9MEfL8ZC3WYBp67J1RrUglT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjO+SAyCF/unwFXMUueJsEsKfdMvPflEPUFHFcO+pg9RbAmh/P1SZfdipexfG7koadxOXb1lWd72O0S1rcXzAxreMhgyAHfXq2KV9UesAynh3bareYNhmooTp8H3Dq+Yw0Nzw67v3bt3D8flW/W11ssAmKTdEim/uqXS/snnYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QO7iuEmW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d6d5765so3067033f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 02:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737455388; x=1738060188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tREQSbIeCuUUo6kw7V1GF3H9V+/GJnzAykBmE1L7QF8=;
        b=QO7iuEmWoihMKxcpCUSyGG3qYpdcdYYsptqpM2GW8vTzztpMc1N2ESu7UFeCBJJGvG
         L/RpXQa87xU+8pwHzp1OPDjmA6Ujfcv6eLoB80UWYXd7KCiwZJOfykju3LbRxQpLNJvH
         0Eh4x1TAjvjwiZMi6/y97nabST67AClFZsoGv/XV7jNdKu1Tudqsf7VYj7TzVqn12N41
         cwVKhUpuoLg2WOS6tnKZ9fG8cE3WA5zoJKtnSG/ePgb7VVhnOi0imZl+Pu47riRq4fIx
         GgiXUzxXQURFqs/3GR6bMTtkq6sl3Jqoc4H+jkieuUlnGczcsiwrJXT9fT2mg+8dtm8k
         j9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737455388; x=1738060188;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tREQSbIeCuUUo6kw7V1GF3H9V+/GJnzAykBmE1L7QF8=;
        b=YyicyGuT+b6b4bKliYH6edKbuSZThorPi9U1eFT3rWd7FctVEd8acV4UtOxL3C27uV
         bEm7shvtniW2uidlTce6H+If+Jw9Ob8ZbfRU2O2AZm2Z3S6WW4+RTmZR82CiyKsTxqxQ
         oTcmfKPre6d8M1fdhkud5QPSAYZZUHP0J9ZVLS2DRZzD+SRkgJly7P6rRcaTTeD/HIFe
         W4mzSqONLFE50jVeUG6vDqD9YwMvom0trg00vKcWF+S1pG4oWd2bdTBUT4q/wriwY+bI
         QSbVcrxVCqOxYMSqoWY5AStOoeFfRjUmcsHbZ48Jj8rOZqa8tGYz0vH8t5ddBDdaXSAT
         70jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUeFsspXMOGY0moUUQj+x7KmTRw3LrcaEm5INyYaQPHf795NQ6uek7gjQWlzcfH79xdVidLZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HRB9oPOBtUpK2rhSBvl6tpt6CJ3G79dmKBNXp0jrtp0CQpFk
	O0vVju+OXjSvsk9mlbIV+Cd7m7EgvsD9n4Sm0GVYcVvvLGBp9+s3sf0JJv359oA=
X-Gm-Gg: ASbGncuk6okFWfKSR5azyQqLsK3IRjaLuX35tGWJX3V1i6q1N/ljGoDoFNBncfO4Unz
	jhgaj42l2IDeUSEzIM5efe8IcevBrOtB5T+RQuJ6D9iFqus2DFUw/aItV2YCHoDZ5Bk+NFidzcP
	F8ObLjRyiTLwhs7uQd/e2gNDKCoKEW/DIWKiiP6Qv6NNPn/efVkcq5uLmPPbv+NG30fUecgNoNq
	KvMgQ/TkKhzmY+ZdMQX8cIJc27xw9knPsOdKfBMx+Mwfz9rxg944DYObFeLQCI4/LPzaXdQWUF0
	cQ==
X-Google-Smtp-Source: AGHT+IH8fxLpytjbLVapxMjdNWG42y58FtVvI1kFX2ItvgsyT/3cMg7QIndqQ1oqiTRwrzLAHF+Waw==
X-Received: by 2002:a5d:4e52:0:b0:38a:88bc:aea4 with SMTP id ffacd0b85a97d-38bf57a2304mr9740432f8f.30.1737455388545;
        Tue, 21 Jan 2025 02:29:48 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322b51bsm13148526f8f.60.2025.01.21.02.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 02:29:48 -0800 (PST)
Message-ID: <8686406e-6124-483e-af87-cc40e4d760b1@tuxon.dev>
Date: Tue, 21 Jan 2025 12:29:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
To: Kory Maincent <kory.maincent@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
 <20250120111228.6bd61673@kernel.org>
 <20250121103845.6e135477@kmaincent-XPS-13-7390>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250121103845.6e135477@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Kory,

On 21.01.2025 11:38, Kory Maincent wrote:
> On Mon, 20 Jan 2025 11:12:28 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
>> On Mon, 20 Jan 2025 15:19:25 +0100 Kory Maincent wrote:
>>> The path reported to not having RTNL lock acquired is the suspend path of
>>> the ravb MAC driver. Without this fix we got this warning:  
>>
>> I maintain that ravb is buggy, plenty of drivers take rtnl_lock 
>> from the .suspend callback. We need _some_ write protection here,
>> the patch as is only silences a legitimate warning.
> 
> Indeed if the suspend path is buggy we should fix it. Still there is lots of
> ethernet drivers calling phy_disconnect without rtnl (IIUC) if probe return an
> error or in the remove path. What should we do about it?
> 
> About ravb suspend, I don't have the board, Claudiu could you try this instead
> of the current fix:
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> b/drivers/net/ethernet/renesas/ravb_main.c index bc395294a32d..c9a0d2d6f371
> 100644 --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -3215,15 +3215,22 @@ static int ravb_suspend(struct device *dev)
>         if (!netif_running(ndev))
>                 goto reset_assert;
>  
> +       rtnl_lock();
>         netif_device_detach(ndev);
>  
> -       if (priv->wol_enabled)
> -               return ravb_wol_setup(ndev);
> +       if (priv->wol_enabled) {
> +               ret = ravb_wol_setup(ndev);
> +               rtnl_unlock();
> +               return ret;
> +       }
>  
>         ret = ravb_close(ndev);
> -       if (ret)
> +       if (ret) {
> +               rtnl_unlock();
>                 return ret;
> +       }
>  
> +       rtnl_unlock();
>         ret = pm_runtime_force_suspend(&priv->pdev->dev);
>         if (ret)
>                 return ret;

The warning is gone with this, as well.

Thank you,
Claudiu


> 
> Regards,


