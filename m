Return-Path: <netdev+bounces-147766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28089DBAD3
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AB928211E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3420319F416;
	Thu, 28 Nov 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKZXiSzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1304204E
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808789; cv=none; b=ATRBvbwF6tGTeR0+PPqTW3Sn63GqSqjONQcQ6T68Eq5fkwwmmXI3SaKVVqfIQXVJlll9vbQU9X8ph4uAm9YeorTeQF3dHqNRwv+OxsyVr7SCLEU4QF/3HcPOSngIpmJDo9mE1woG2R5N3QxUVlQYbacMGm/EqULjRWRzkvHG8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808789; c=relaxed/simple;
	bh=d689coZT3boFWBhjrZtTDVowTMClLnXC6g1ntfmEwVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBLHEovtc/OuaiG6V+PQ/KAfmHyJ7WvDOKjFdRnNLiYZFvz51abWC9vGGp1SYliK9Qkfie3SNkQ9+j9tkfGQ1zYrl/cyNulzXAbTYWJWAjUHsoX2D94FvlHakg2At+cqXpGJdr+/flaHRVh4/ErNrxjIAyJx02wZ0vIsNkh0T5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKZXiSzf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4349c376d4fso661845e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 07:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732808786; x=1733413586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d689coZT3boFWBhjrZtTDVowTMClLnXC6g1ntfmEwVY=;
        b=HKZXiSzfN9a7RtGfYHs13jX1oimZ37GKyRD3e2iOEBSEU8uRL8Zvmt63nn3XbBfc7g
         anTIsrxGPTm92Cas+6pAJNVQMolywUuS3KHLzXcxWaoQjnT4zcZlMtyLotskm794KX0F
         f6PGgLuW2AZkwVJFUOIw8TudZ3H+ozImf4RnpU6Y72OcXhOkB2pbm2bM2PZmzFBTQxF6
         po9VjJA3OuNoiCKberQVhGq1SoU4UWW8s6d3qSt+w7OPYJe1d6OoPveEnDqHkO/M2r3u
         lXvIrHnyP0UJjKkw8oK2z+h6HosVnZlS/sBp+1HrJrkIKuOHAjYCwQNXZuZFcFCXofO6
         FLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732808786; x=1733413586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d689coZT3boFWBhjrZtTDVowTMClLnXC6g1ntfmEwVY=;
        b=GAdlQNeb0ZWbRMF2SYAN1exQNc2Ak83sZVMhPxhmDRr1vmaJ47fXyfUV9PrqSLW2Yj
         voXWb0t+moBa+QSxvoZWe9RafTQa5p2mDhkcs4D7iqlDfuXZ2F+0abD26O0EtVmcself
         GCRu35fEJ5gRzA33HlF/ZOF0rkaWwBxuZpC/6D9f4aN7ntPDLCMDWQsuAmwTAuRIoZOb
         YO2ySsDDr0BtLRdeSYrOg32cELiyKi8UmUrbrKr+mgf9Ru2DEg+ianLfcsFEF5nqmxmM
         V12OsPCnqaXkxJifcjy/D+hIQmSBeafYRu/KQn35HCs+G6TZnA2DC74ox8rnQJvA+rBR
         V6jw==
X-Gm-Message-State: AOJu0YylXmLqBZh9y4n5/SKliz+9XwAI/qt0P5QEMJDjJ8lymmoPhgLR
	dw39tZe44CIn+jkdXr33X64d9pOeGF8msKZqDMF5j9EmVaiKUcWr
X-Gm-Gg: ASbGncu05Dyv4yHvG/T7mhru6fMp1kLsE6CcglRCmyRyQaeoZmRMtr5zXgpKLZV55kZ
	QnrZyEqp+yLG8Ep1OrXq1xRThtdD1xQs0d/E8uZHAwxyZTCtt6LNd2yFyNtoKuf+B41JRnYfduK
	6rbNjB7XN1Q6Fd4LCtdGMp4kBwz2lhhgkVW3Z9kc64Cd4FqeCNBgsId/3+1E5jQ6Ng2pEJ0nci3
	ZxH05WD3lArhtd2wkJBbHoPlMSUSbzgYq7XgYo=
X-Google-Smtp-Source: AGHT+IGgVyANm0B8gveU4acaYTsQvGiO/cTKLha8d7stGLv7wnQH8l8hkqK7YnSB7z2LcGdFrfqKZw==
X-Received: by 2002:a05:600c:4447:b0:434:a0cb:6d24 with SMTP id 5b1f17b1804b1-434a9dc0c14mr27076255e9.3.1732808785411;
        Thu, 28 Nov 2024 07:46:25 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc11sm26190365e9.4.2024.11.28.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:46:24 -0800 (PST)
Date: Thu, 28 Nov 2024 17:46:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jesse Van Gavere <jesse.vangavere@scioteq.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"woojung.huh@microchip.com" <woojung.huh@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: DSA to switchdev (TI CPSW) ethernet ports
Message-ID: <20241128154622.45ohunthnz2wowvw@skbuf>
References: <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
 <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
 <20241128141948.orylugaetrga2bdb@skbuf>
 <PASP264MB52979414E483480C8FD26218FC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PASP264MB52979414E483480C8FD26218FC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>

On Thu, Nov 28, 2024 at 03:42:18PM +0000, Jesse Van Gavere wrote:
> Thank you very much for this information.
> It immediately pointed me in the right direction and I could see this was Addressed by Jacub Kicinski in commit 29c71bf2a05a11f0d139590d37d92547477d5eb2
> The netdev of_node simply wasn't being populated yet in the branch I'm working on, everything is working as expected now!

Happy to know it's resolved. Just want to point out that the patch was
authored by Alexander Sverdlin. Jakub Kicinski is the maintainer who
applied it, and provided the last sign off in doing so.

