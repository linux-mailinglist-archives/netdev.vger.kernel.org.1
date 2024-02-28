Return-Path: <netdev+bounces-75694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D486AEE7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1444E1C20F29
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024673527;
	Wed, 28 Feb 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mv7QAL7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA977353F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122491; cv=none; b=LS7HeUDutFMGlsGIxLya/Or8sGb5q70l2MxLy5mkv+Ua8gPgn2/naGfvmX17ntBsGLObpYJgtkA0RUgzeEof82eJPK1IVezEavSRxvA3z8sz89zPrnIL6OCKOOENnq/hmjc8Yi7rIGy5tcRHTItRXlYkzkEgy/uqLe0ls5AIVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122491; c=relaxed/simple;
	bh=XRJuTkht8FxfCspd+iue+yvGTbmirCbnGs+3Uw3zWFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VttcLYIfjDnsD37/qJ6aGByuwfww5hAow3Gnh1NagEwGUEEKCTcnUsfI3Sp1z8ShQleXaoSHhgsVv5Nj36y8mQZP6hEh71KFMOgiDs2gYxITRhnOG6//RwF3vEM/fWE6jMDy6to7NgYVfEv+XS8vIn+XYS0C0YlCkYis1XlZBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mv7QAL7V; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so6337284a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709122487; x=1709727287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNYMykttlXrGu+y3ZcK4zIjxaM0WUhP8MC7XJIO29wk=;
        b=mv7QAL7VImTTNEz70Ce6uwUSejXL3dgD6uLW3WhEVArww9A1a8FcQpw07C1pRD/srQ
         sLwmsgUSK3Od4YidKCnY1d5ixQDxTITMfILYCPteXixiXDI140lwqrwwfrnrfpJuSXib
         e1VRWM4HIUuLkuHhiyX/orREXsmgB1eJXyXL5iEdw+nBfY3MRgY0M0Fr/7pA8VUaa5Pc
         HEj38qixmp6JnOG8FjOUexhkUBKoE/52yAdOCJTL+ys+ZRqcmFSh2GWimRIXNKZcLfCg
         HAYCt/yUZ4QwBdsr+2L/d1EbKT0R1MOOAPQfbyqAhv7vYtf+xM06YbVj/2A/xYSdyvgx
         U/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122487; x=1709727287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNYMykttlXrGu+y3ZcK4zIjxaM0WUhP8MC7XJIO29wk=;
        b=pQjMOgsZeBL7VhMaIEbYvz/dvgNpnGzCMCFApO66Swg2Z+OWmE+e+EcQ8YgAG+JIOV
         RFTmmvAn/Q++G5BCUeKyBvNFMo2xV5D3lZyRwM8+QsWIiSE40CB8P5lyldBhZac51vGh
         L3eQFqKpxw7xvFAvRSZr8V6a8Jo3mLuO4ZxOuzDf5Si5lMDiCevwqmH6nojvRRVSzoG0
         0Ge3TQHX08H9SsTVFW+eyGyiyo83xP514NCeUVrB/mbB6fHo0GGk8RcSDxU/Gaz/wrEp
         TuwoCQ7dK4J93B7JuPju4H+rtNTb06rOk+ySdrNtD4wf1LKz8FKZY5Fr65CjchygbdHQ
         /yCg==
X-Forwarded-Encrypted: i=1; AJvYcCUfhMIb9BSvKu/MF+h82ljfUEqcSDI2oWGsmcKz/QQtl7zciNFbsL25aWo4yjufVCquUOMqoPEjhJi8ifLXqzwUYmd1jPRI
X-Gm-Message-State: AOJu0YwNoOjDDZQLEJQUWwdAOZQ4VEBYdU4rqDRJ+YW6XTF3gHtPo4Te
	MVVgNrrcXOVat7nk8c2fHpjJGD2CgrNoJoujSo7QGS5XKxQwvmtLJNwjw6rk9bAR2wqLWBnbXC3
	n
X-Google-Smtp-Source: AGHT+IGh73Y5mwH/q9NIDOFycKr698w+3J5hP8zWoSzRrNokpqVNMgBoMAn7izajjDIbM8mozmLa+Q==
X-Received: by 2002:aa7:d716:0:b0:564:4f6f:a7ff with SMTP id t22-20020aa7d716000000b005644f6fa7ffmr8206102edq.20.1709122486808;
        Wed, 28 Feb 2024 04:14:46 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ec31-20020a0564020d5f00b0056650cd0156sm1048290edb.66.2024.02.28.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:14:46 -0800 (PST)
Date: Wed, 28 Feb 2024 13:14:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 1/4] devlink: add two info version tags
Message-ID: <Zd8js1wsTCxSLYxy@nanopsycho>
References: <20240228075140.12085-1-louis.peens@corigine.com>
 <20240228075140.12085-2-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228075140.12085-2-louis.peens@corigine.com>

Wed, Feb 28, 2024 at 08:51:37AM CET, louis.peens@corigine.com wrote:
>From: Fei Qin <fei.qin@corigine.com>
>
>Add definition and documentation for the new generic
>info "board.model" and "part_number".
>
>Signed-off-by: Fei Qin <fei.qin@corigine.com>
>Signed-off-by: Louis Peens <louis.peens@corigine.com>
>---
> Documentation/networking/devlink/devlink-info.rst | 10 ++++++++++
> include/net/devlink.h                             |  5 +++++
> 2 files changed, 15 insertions(+)
>
>diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
>index 1242b0e6826b..e663975a6b19 100644
>--- a/Documentation/networking/devlink/devlink-info.rst
>+++ b/Documentation/networking/devlink/devlink-info.rst
>@@ -146,6 +146,11 @@ board.manufacture
> 
> An identifier of the company or the facility which produced the part.
> 
>+board.model
>+-----------
>+
>+Board design model.
>+
> fw
> --
> 
>@@ -203,6 +208,11 @@ fw.bootloader
> 
> Version of the bootloader.
> 
>+part_number
>+-----------
>+
>+Part number of the entire product.
>+
> Future work
> ===========
> 
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index 9ac394bdfbe4..edcd7a1f7068 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -605,6 +605,8 @@ enum devlink_param_generic_id {
> #define DEVLINK_INFO_VERSION_GENERIC_BOARD_REV	"board.rev"
> /* Maker of the board */
> #define DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE	"board.manufacture"
>+/* Model of the board */
>+#define DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL       "board.model"
> 
> /* Part number, identifier of asic design */
> #define DEVLINK_INFO_VERSION_GENERIC_ASIC_ID	"asic.id"
>@@ -632,6 +634,9 @@ enum devlink_param_generic_id {
> /* Bootloader */
> #define DEVLINK_INFO_VERSION_GENERIC_FW_BOOTLOADER	"fw.bootloader"
> 
>+/* Part number for entire product */
>+#define DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER       "part_number"

/* Part number, identifier of board design */
#define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID   "board.id"

Isn't this what you are looking for?

"part_number" without domain (boards/asic/fw) does not look correct to
me. "Product" sounds very odd.

pw-bot: cr



>+
> /**
>  * struct devlink_flash_update_params - Flash Update parameters
>  * @fw: pointer to the firmware data to update from
>-- 
>2.34.1
>
>

