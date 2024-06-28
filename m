Return-Path: <netdev+bounces-107711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A691C0F7
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC13F2812E7
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE6156231;
	Fri, 28 Jun 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfWlBq6u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159A1BE87D
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585008; cv=none; b=hxuST0fCjuhKq6MGtYxfB3KvJzJE8Tqfu50A405s273uxaPshmgXi7GQtcqVTihzH9KUdpeBEYHM1JHCarxOdUTweyRIAkcAdb7IqsIcdjTP9L7IhwuU7TdMO+/5wZ0sdnuor1R0dkintdGRWbXPJ4VaqLR89LnJVBmdk58O+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585008; c=relaxed/simple;
	bh=Ibid4PIt76VlNdlZcPEwecMq9F81ks0B0k+rnRYWOaI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HsUhjmfEiQSI2F53/Ehfg/MPuNAVob9ET6BSDG6bZNru1JElkR31YWIJmmq+DGPPQCDQwVQeoXy6GXTh1koFI8YBWnDfvL8qS/NY5EPMtGKgnDFf0jStbSHvUIVjb4Bxt68XxB0+nxJpIoucmuscBWliGq7OCLiO0wLOnAi08nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfWlBq6u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9c5230382so128875ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585007; x=1720189807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDBuv9V3qEK6sWcNnycCpdmP+3M2flGTyaltHxUgG4Q=;
        b=JfWlBq6umF7JOXz8rArPsMORhbvRc3lHaeAjJw83fKk1HLWkxKYbunYB/jhNmI+/Y9
         fFj4CxgWd1wTp+qcL+hd04alSaRfW0GYprhg6G8wlc9LQvZglVZgUHAkOFVnxHAH7S3P
         FrHZ4/zLHaSlC5hdsnIqQKThtCEBcEe0UH2cNDki/hc2N4FhN8SzT+VNm9WSOKyc5DuR
         EOJ95pH9kJP4aVTt7Gd/LZYXneOuQfg77ikKQz6fXPAXt/Sa9pxNip7WvhKeKXvPS8up
         VVzpAdZfQIAbQR9+SdDMog1stcWWMv4iSZwKRiHqtFGCrEXgFxBIj+urue7xd1/agv+e
         gECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585007; x=1720189807;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pDBuv9V3qEK6sWcNnycCpdmP+3M2flGTyaltHxUgG4Q=;
        b=v3fru9id53oA2mqI3RmrpoAzsaKXrY8ilUNM/DrhLWWuAmrraVgLDjf4lWYGDGh3DZ
         jaW3yH4U5IG57FGJbpbuQBOy6+at37bVQR0r2nOYUirM84iRJFOzc0pFQoGwtPYWKMoz
         xWhDJzRShHGcOEMzjaOyIWS9/KhWZZ3nh5vK1JTC68Yd7v8kZuYC5ZPQnAkOhYt/MUa7
         VELxmDL/m1wGRCemV/kaMPz3/4RB2w4C2iilz9R/VL7Fu+hhOIdhKR5Lf+gGFxbS+rBA
         raT25uEiV2S3r4JF5Oy2wd8XV1NVKUdgeq2SWXtgTSPGUqvCYHBkMfbhFyh0dfGw/3Xl
         o++w==
X-Forwarded-Encrypted: i=1; AJvYcCW76N8zDxHxiGv1dxy5uo26VgRNnIYfp26/N4qdwKlkIzoHSyjt1T2geOJQoc8o1reFqWtQVCr76YDNAL0gY71wJTLI7lmM
X-Gm-Message-State: AOJu0YwDisUDbyiENhrOqw4eafp5sj2J/LkUehNrxcn1E9hEvpNUaSQT
	qsHSQOhoS7i9ejIuOZpXvTL06UfHMwlPxQRdzpcR+as+xVRMf4/T
X-Google-Smtp-Source: AGHT+IG3iV+n/Gel2dqGxmEZInmtHT89kH6dUPe7PcKtf+a6s8BPpkPKvOrNi9bPVm3SZ4qPnCP8UA==
X-Received: by 2002:a17:902:e54e:b0:1f7:2b3:3331 with SMTP id d9443c01a7336-1fa0d81773emr204111375ad.4.1719585006903;
        Fri, 28 Jun 2024 07:30:06 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569449sm15878575ad.220.2024.06.28.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:30:06 -0700 (PDT)
Date: Fri, 28 Jun 2024 23:29:52 +0900 (JST)
Message-Id: <20240628.232952.860169904679046997.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk
Subject: Re: [PATCH net-next] net: tn40xx: add initial ethtool_ops support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <fe33e69d-a17b-4afd-a5e5-1e1539e6572c@lunn.ch>
References: <20240628134116.120209-1-fujita.tomonori@gmail.com>
	<fe33e69d-a17b-4afd-a5e5-1e1539e6572c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 16:14:44 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +static int tn40_ethtool_get_link_ksettings(struct net_device *ndev,
>> +					   struct ethtool_link_ksettings *cmd)
>> +{
>> +	struct tn40_priv *priv = netdev_priv(ndev);
>> +
>> +	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
>> +}
> 
> Have you tried implementing tn40_ethtool_set_link_ksettings() in the
> same way?

Not yet. I'll try. The original driver doesn't support
ethtool_set_link_ksettings().


> This patch is however O.K. as is:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks!

