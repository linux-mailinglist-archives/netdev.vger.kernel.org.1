Return-Path: <netdev+bounces-181206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D8A84131
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541E17A9DDA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFDE26FA40;
	Thu, 10 Apr 2025 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfmtYXQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA9267F7E;
	Thu, 10 Apr 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282268; cv=none; b=VtTWeg6+dJUJuFOGrftphKP5pFtEa6ZNsVZOK3eFcscLUxgGN0kldOyTKLTgihqvGrrJfB3MJZm4O1crq5m3ccLPoHy6cYsCZo9C63lv/XWSyphH1MEIpkPFnyo0MDgv9cTnzhbImg+EoX0ZOzIzWkd1gqxqUOUWyMW3ypRS9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282268; c=relaxed/simple;
	bh=C/+Ts8TAkgYcrilOS0yU/JF9ewSU21dkV6ZWeqpvsEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTG17wEjKVrC0Trbq34re0D64j1ya5zcxWBfjq2sKInTOmuJze/M1H6dHGydsrDWFWkVSLJCe5Zwouxlhc3Isu6AOpvzKcRhGTZ228dPCvrmGtn1msoCD+Y7+os4Q4AjaJ9XFG0Cdop0FgJbnjxitmP7tcE67ZxdTu+y4XTSON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfmtYXQ8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a04so6858631fa.2;
        Thu, 10 Apr 2025 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744282265; x=1744887065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NaIKikKt3YMQqZgEcHE/86CGwkWY+nKD1/5iMoYSOLU=;
        b=dfmtYXQ8Dc2iErMp5ADrsOLFCjnGR8UxNRsXJYaWBXYOv0hbky2Xl4kfOSLTnOy+Qg
         FJNnh0mD9YyrdefM53IhZ6LVRyQtEARZ/Nfz+OZ8M0Xu0y9VTSPG7vELfmKn81j4Lp/5
         Bx9HhKP5w9hnQ++36C8AxzJe8noxwvVXjpSXja4cgdNjFr5T6hinZ84uuf8291tJdwWe
         dLP93IVbuzlBzHY6VtCpQWsUF8y5fm2I58PwnWjiz7I06hIXbkJq2SWdZOSadzUjWOhq
         tLZeHomSd3+QXG67NEV2DR/jyMBrmMV5QF6AZoBD4An+/WuVgV6uvWOKWXFpZRpJQ/Xc
         gxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744282265; x=1744887065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaIKikKt3YMQqZgEcHE/86CGwkWY+nKD1/5iMoYSOLU=;
        b=L4iEo08aKjEMn8msSzo8Vv14Et9w/HbIHJStpnuNsd8lP3QtQqzHgtl3Fp7DNqp1N0
         F0kb92PADzoa8mTxgsJqyyByZxJ1KS16wlPXUEykwvAUDoZJ7Hkbw6r/h7E/vJ7qCbLR
         /mb8Nzb9+6QNy4ayzQqkbbi/sPt7GLxbwtsTPD6SUIlifk7EI14O4IhoptG80jXZQw3+
         EADz4s8eCuO8+5tWLH0cdMTT2WfEyNj0M86iug9YOf1GBW8VKu/VM8Qj/+54oji0xDqM
         Jf8/ltJJ/vKdOdEvbbTnmL6fhBvND9Ibf5SW7KefpYCn3cgW1ga+YpZHY/gMKyFjrC38
         5aEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6yAZiXk6fwZf9z74hPJl9QDUE1pJ41/E3eUGLJxnI5fuKDjqoayiQmEJRXzWDbSHyxG8z7bBEkViUDT0=@vger.kernel.org, AJvYcCXgaD94pcVlmHlIyElRRS/TLwfOOBNBd0MfFe9ObrS0Y5C79lxOtcE+a2clPOm2/KlCf8l6vLUE@vger.kernel.org
X-Gm-Message-State: AOJu0YyBNxbEzD059T6wy0GINdf3pa9RsxfrJlYQpGkFiA+HuD3OMdZ5
	PZcEpcu6mzmpggRzg4/An7qEbz+iFTWI305kKcLV0nEr+q77BVCL
X-Gm-Gg: ASbGnctM1ywyZy+TUhR4XW3apPp3ho2ZMzxUqkvhfz/BknIxgGIdZ4TZcIS/3mAp1Gz
	mQEn9GN1AqDeXq760yRrJGz7ex0x8+J9aLbZZD0BKxaN4TOmCl1o9JH2tnmn+BSIzkYC5Iuyor3
	w1dkVN4PHbrX+ZPVgb8hov9J+AJSBg7Sf/BA9MQBDcsr91dJ3IzgC1NP+64jeN6PERci0reePvJ
	FG55NCLqEPFVfUKFoPYDvX1Ah4Ci71sjmqU2XSDyuc1KHItbXwhqMJYCCwq9bfVPFkb6xM5i51O
	i/AqDX3jZcugSe9leNs2HaGa7xeAoUP/HEm6b4uz0cuhy9MWFhQBZyI=
X-Google-Smtp-Source: AGHT+IHfXaOWjvGmI+OH/GNsAjKhgDg2ZW+9CjZqd763YzGH0IvbBan82S/U/tgtfDT8VGnz/ltYBQ==
X-Received: by 2002:a05:651c:512:b0:30b:b78e:c473 with SMTP id 38308e7fff4ca-30fa41a5194mr6558841fa.7.1744282264322;
        Thu, 10 Apr 2025 03:51:04 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f465f836bsm4447501fa.109.2025.04.10.03.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:51:03 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 53AAp0sc001656;
	Thu, 10 Apr 2025 13:51:01 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 53AAoxkv001655;
	Thu, 10 Apr 2025 13:50:59 +0300
Date: Thu, 10 Apr 2025 13:50:58 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: kalavakunta.hari.prasad@gmail.com
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com, hkalavakunta@meta.com
Subject: Re: [PATCH net-next v2] net: ncsi: Fix GCPS 64-bit member variables
Message-ID: <Z/eiki2mlBiAeBrc@home.paul.comp>
References: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>

Hello Hari,

Thank you for the patch, it looks really clean. However I have one
more question now.

On Wed, Apr 09, 2025 at 06:23:08PM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> @@ -290,11 +289,11 @@ struct ncsi_rsp_gcps_pkt {
>  	__be32                  tx_1023_frames; /* Tx 512-1023 bytes frames   */
>  	__be32                  tx_1522_frames; /* Tx 1024-1522 bytes frames  */
>  	__be32                  tx_9022_frames; /* Tx 1523-9022 bytes frames  */
> -	__be32                  rx_valid_bytes; /* Rx valid bytes             */
> +	__be64                  rx_valid_bytes; /* Rx valid bytes             */
>  	__be32                  rx_runt_pkts;   /* Rx error runt packets      */
>  	__be32                  rx_jabber_pkts; /* Rx error jabber packets    */
>  	__be32                  checksum;       /* Checksum                   */
> -};
> +}  __packed __aligned(4);

This made me check the Specification and indeed somehow it happened
that they have forgotten to ensure natural alignment for 64-bit fields
(at least they cared enough to do it for 32-bit values). [0] is the
relevant read.

> +	ncs->hnc_cnt            = be64_to_cpu(rsp->cnt);

This means that while it works fine on common BMCs now (since they run
in 32-bit mode) the access will be trappped as unaligned on 64-bit
Arms which one day will be common (Aspeed AST2700, Nuvoton NPCM8XX).

So I guess you should be doing `be64_to_cpup(&rsp->cnt)` there.

[0] https://www.catb.org/esr/structure-packing/

