Return-Path: <netdev+bounces-75964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD786BC96
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6650828879E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29AA28;
	Thu, 29 Feb 2024 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGy0WtMM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA17FE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165739; cv=none; b=IL8OmSPx6XtA9R/SRdRJ+vUZbOf7McAPXWPa8kJuSTVknjmR5E3U3ZUDfH1EEn8Mpc6mLbR0HKQlE8k0quBU+wb4g2d2QzOn6UZpyz2j7b9DxkgijcdJa2fLYdngE7szb0jmF3OztPbJocMut0eQXLUYPohxBj6MM6RV0QQtktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165739; c=relaxed/simple;
	bh=KFpGHaygOWnJZs+S5tsNAPLYMttJbW5qbzuu4vmTpc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfbe7Z7Cp3JSk/UtL3G9sa0AicgdcO0mOy7snKIn5R7C6OC/u9UUHuObREt6NjJ1Bs5DB6OcVcJY/GzfaxH+b4/STFHpKWj9jtbtynx8nme3Pf70TwQc9m6SNzMneusBCle1UPLGl8TtOcxJqcLm4pFqhT2sawVOMLVhjo99Mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hGy0WtMM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so2996555ad.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709165737; x=1709770537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl/GQscns58RVf5+2mGUWDm5GmcEQAfx5f0kshMZgAg=;
        b=hGy0WtMMyq/7SSgQO29K2djMuuvM/SiqF/PLXBkbFLcSSP3nloMA4w3gALA4ArPl7H
         Kzan5v1wo2Ju4foH/zqAEvgv8yVAYkcSSoLe+esrg2KujTEtB6cVI53iQDu61PiLyQdx
         39JroGTTMyfNMs0Kxk/bH0CXeNS4yowA77ru0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165737; x=1709770537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl/GQscns58RVf5+2mGUWDm5GmcEQAfx5f0kshMZgAg=;
        b=YqoJE6TYrfT4nd2XlAORCddfctewJZTzchycdtmD/S00sK7sw8sqv5Yq+w10nZ9FhJ
         fDjGVgpQK7pUqM2dVYs1N6HCJQzUHxLNzoSp3POY6YXiCOsvPnskSxwy9o/06sBsKkaI
         EZ0JV1iGQK2AfWtd5f2ty9LaJB0C77ypaSRYwpmNwSt099XYjU4JHxpNFouOoCW3bBk2
         g57iY6M1i+eseKzop2AQJf2myh53lD74vDFJE2wp0rNDXfICsFLXsRg9RdX7G1mcY6hT
         31d+MgscRlx0Ca/O30mJ3pG7K64QDfFTpOlxGKRxUqkA2EOZASGHHbyjUCd4baCLLogy
         4wPg==
X-Forwarded-Encrypted: i=1; AJvYcCWzGUm3eWqlszSTey/Xy/1SgpNWIGyDmMsvecIAjyojRGLJXNxPAFVnTjtDrdquKIb4RSrqprPSwOH5oHsaJ74Bmqn0YTpW
X-Gm-Message-State: AOJu0YyLLtDyw+mS70p9KgEwH7OqH1rXvxemaVrfnJNVe0dwom7VjLLb
	TFfsTdwFRss6ZqV5dqBc0ylCYjmpOZkQ4cnfgJkZNKPm/rJkS3humkIiyAQStw==
X-Google-Smtp-Source: AGHT+IHzIAviZPXDsQ2a9pCkRPqaZL+hqxFBObnzqP5Kwh51sYmhd/jFpQPt/tKQjXbPEaA3tqt85A==
X-Received: by 2002:a17:903:181:b0:1dc:cc0c:a29f with SMTP id z1-20020a170903018100b001dccc0ca29fmr507842plg.4.1709165736703;
        Wed, 28 Feb 2024 16:15:36 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902779400b001d94e6a7685sm41728pll.234.2024.02.28.16.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:15:36 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:35 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH v2 4/7] scsi: qla4xxx: replace deprecated strncpy with
 strscpy
Message-ID: <202402281606.199AC93A4B@keescook>
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
 <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-4-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-4-dacebd3fcfa0@google.com>

On Wed, Feb 28, 2024 at 10:59:04PM +0000, Justin Stitt wrote:
> Replace 3 instances of strncpy in ql4_mbx.c
> 
> No bugs exist in the current implementation as some care was taken to
> ensure the write length was decreased by one to leave some space for a
> NUL-byte. However, instead of using strncpy(dest, src, LEN-1) we can opt
> for strscpy(dest, src, sizeof(dest)) which will result in
> NUL-termination as well. It should be noted that the entire chap_table
> is zero-allocated so the NUL-padding provided by strncpy is not needed.
> 
> While here, I noticed that MIN_CHAP_SECRET_LEN was not used anywhere.
> Since strscpy gives us the number of bytes copied into the destination
> buffer (or an -E2BIG) we can check both for an error during copying and
> also for a non-length compliant secret. Add a new jump label so we can
> properly clean up our chap_table should we have to abort due to bad
> secret.
> 
> The third instance in this file involves some more peculiar handling of
> strings:
> |	uint32_t mbox_cmd[MBOX_REG_COUNT];
> |	...
> |	memset(&mbox_cmd, 0, sizeof(mbox_cmd));
> |	...
> |	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
> |	if (param == SET_DRVR_VERSION) {
> |		mbox_cmd[1] = SET_DRVR_VERSION;
> |		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
> |			MAX_DRVR_VER_LEN - 1);
> 
> mbox_cmd has a size of 8:
> |	#define MBOX_REG_COUNT 8
> ... and its type width is 4 bytes. Hence, we have 32 bytes to work with
> here. The first 4 bytes are used as a flag for the MBOX_CMD_SET_PARAM.
> The next 4 bytes are used for SET_DRVR_VERSION. We now have 32-8=24
> bytes remaining -- which thankfully is what MAX_DRVR_VER_LEN is equal to
> |	#define MAX_DRVR_VER_LEN                    24
> 
> ... and the thing we're copying into this pseudo-string buffer is
> |	#define QLA4XXX_DRIVER_VERSION        "5.04.00-k6"
> 
> ... which is great because its less than 24 bytes (therefore we aren't
> truncating the source).
> 
> All to say, there's no bug in the existing implementation (yay!) but we
> can clean the code up a bit by using strscpy().
> 
> In ql4_os.c, there aren't any strncpy() uses to replace but there are
> some existing strscpy() calls that could be made more idiomatic. Where
> possible, use strscpy(dest, src, sizeof(dest)). Note that
> chap_rec->password has a size of ISCSI_CHAP_AUTH_SECRET_MAX_LEN
> |	#define ISCSI_CHAP_AUTH_SECRET_MAX_LEN	256
> ... while the current strscpy usage uses QL4_CHAP_MAX_SECRET_LEN
> |	#define QL4_CHAP_MAX_SECRET_LEN 100
> ... however since chap_table->secret was set and bounded properly in its
> string assignment its probably safe here to switch over to sizeof().
> 
> |	struct iscsi_chap_rec {
> 	...
> |		char username[ISCSI_CHAP_AUTH_NAME_MAX_LEN];
> |		uint8_t password[ISCSI_CHAP_AUTH_SECRET_MAX_LEN];
> 	...
> |	};
> 
> |	strscpy(chap_rec->password, chap_table->secret,
> |		QL4_CHAP_MAX_SECRET_LEN);
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/scsi/qla4xxx/ql4_mbx.c | 17 ++++++++++++-----
>  drivers/scsi/qla4xxx/ql4_os.c  | 14 +++++++-------
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
> index 249f1d7021d4..75125d2021f5 100644
> --- a/drivers/scsi/qla4xxx/ql4_mbx.c
> +++ b/drivers/scsi/qla4xxx/ql4_mbx.c
> @@ -1641,6 +1641,7 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
>  	struct ql4_chap_table *chap_table;
>  	uint32_t chap_size = 0;
>  	dma_addr_t chap_dma;
> +	ssize_t secret_len;
>  
>  	chap_table = dma_pool_zalloc(ha->chap_dma_pool, GFP_KERNEL, &chap_dma);
>  	if (chap_table == NULL) {
> @@ -1652,9 +1653,13 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
>  		chap_table->flags |= BIT_6; /* peer */
>  	else
>  		chap_table->flags |= BIT_7; /* local */
> -	chap_table->secret_len = strlen(password);
> -	strncpy(chap_table->secret, password, MAX_CHAP_SECRET_LEN - 1);
> -	strncpy(chap_table->name, username, MAX_CHAP_NAME_LEN - 1);
> +
> +	secret_len = strscpy(chap_table->secret, password,
> +			     sizeof(chap_table->secret));
> +	if (secret_len < MIN_CHAP_SECRET_LEN)
> +		goto cleanup_chap_table;
> +	chap_table->secret_len = (uint8_t)secret_len;
> +	strscpy(chap_table->name, username, sizeof(chap_table->name));
>  	chap_table->cookie = cpu_to_le16(CHAP_VALID_COOKIE);
>  
>  	if (is_qla40XX(ha)) {
> @@ -1679,6 +1684,8 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
>  		memcpy((struct ql4_chap_table *)ha->chap_list + idx,
>  		       chap_table, sizeof(struct ql4_chap_table));
>  	}
> +
> +cleanup_chap_table:
>  	dma_pool_free(ha->chap_dma_pool, chap_table, chap_dma);
>  	if (rval != QLA_SUCCESS)
>  		ret =  -EINVAL;
> @@ -2281,8 +2288,8 @@ int qla4_8xxx_set_param(struct scsi_qla_host *ha, int param)
>  	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
>  	if (param == SET_DRVR_VERSION) {
>  		mbox_cmd[1] = SET_DRVR_VERSION;
> -		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
> -			MAX_DRVR_VER_LEN - 1);
> +		strscpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
> +			MAX_DRVR_VER_LEN);
>  	} else {
>  		ql4_printk(KERN_ERR, ha, "%s: invalid parameter 0x%x\n",
>  			   __func__, param);
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 675332e49a7b..17cccd14765f 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -799,10 +799,10 @@ static int qla4xxx_get_chap_list(struct Scsi_Host *shost, uint16_t chap_tbl_idx,
>  
>  		chap_rec->chap_tbl_idx = i;
>  		strscpy(chap_rec->username, chap_table->name,
> -			ISCSI_CHAP_AUTH_NAME_MAX_LEN);
> -		strscpy(chap_rec->password, chap_table->secret,
> -			QL4_CHAP_MAX_SECRET_LEN);
> -		chap_rec->password_length = chap_table->secret_len;
> +			sizeof(chap_rec->username));
> +		chap_rec->password_length = strscpy(chap_rec->password,
> +						    chap_table->secret,
> +						    sizeof(chap_rec->password));

This hunk took me a bit to convince myself it's safe, but yes, I agree.
It all boils down to sizeof(chap_table->secret) being less than
sizeof(chap_rec->password), so there's no behavioral change here.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

