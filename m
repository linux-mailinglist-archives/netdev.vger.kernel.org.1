Return-Path: <netdev+bounces-70775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C88505AF
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 18:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F1C28140B
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070875CDD8;
	Sat, 10 Feb 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ErSf6bi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13951016
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585670; cv=none; b=X/5Smk8y6u9wYwsrg5nUkWEgXa56OASei70edUhh4eX+QVOKoF+bTP3JXCw3pgPqX+xOEs99OBrVCWvuM0zy3oc8ldl0FLNtMAUjrRNmAZHEoBTHO+PsUjw38imfty7lku0d/QSL70+OS8tXrDdv1ouaZKYulekIor8l0JgYOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585670; c=relaxed/simple;
	bh=nBtRQQSzo00f5BF7zrXZ9Ub/bVow0BWKpXCj6ryZCiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PePCk+mtOTy3k1TloGeFx/wdMLqAaWdSv8BX0GD+MWXxxX8NvF3sKd5UcxYADPM2xDPJeFOHkDylOlGEHG55+SZjIBhlLHUYGC3KyuG3O1+wOAMO3Fsj2yacWsGmaeLScmDqoMV+idrn22v2n9JgKnFfVMFuGMFAf0HtcINmYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ErSf6bi7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7431e702dso18296395ad.1
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707585668; x=1708190468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLI+V2nx7lYoAzjEUyR4toE1LpLIFSiv93zWRg3jk80=;
        b=ErSf6bi7d5rXYZ59NXv3H+yvFohb9cTJgo5sKnrXwdGP2k4NsfGoHmARlcgnTCtZFg
         1Cx/M5UqBnwcquePRCmJZWtRbS/xHLwNKUMF31lsE0dlV4V5K0mrMmRbedH5BssSgB5O
         dsAImndNQfSAV6dMTlLg5/jyGQUF4KVzUEnzP31/HxLfJjalYwiPTc1C/oRFuWnnpbWh
         CUCo34t9UVF+E7yKRkdYMH6i4LJY9dMC8/SLLZ1J/fXMhWuWk9747w3vhNbshv5iJOqQ
         VH6q+qsmBZ2LnPXgOY3+LJN/oBsRx12JuZEz754OOERoU2dc4Zbrgm9s+f0uPv9D7JM7
         3j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585668; x=1708190468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLI+V2nx7lYoAzjEUyR4toE1LpLIFSiv93zWRg3jk80=;
        b=o8rKD47lTv+jZ1uLeSg1uVz71TYaeCqkNgM5bV4x6DM7a1HEiu9GW+67hpMptlxR5z
         RKQzlsZUHUz+Z3vTmS2p9v9+LhnG+RnWrUzhdAmNbLw/V9rUcOH7VhWr2NAComqu4hil
         bQmTTjjvzz+FG85CFWiDaVJFUPhjFOTtuUbDRwvvbTPUaouECUzhCKKl/IFTQDO3hZZl
         OcfBzrdhKzjIRB1QypeLWPcuLW1ZGiSAXArhACtU0eMofXOCXRB50sTiv0g2EZ0Gyp8b
         zlf5yKftw1Ki/berdTeJ1rSgq0wjhkDiVkhG83osgQkJC4aTHwamqxg7dSDbumGkbLWJ
         VDOw==
X-Gm-Message-State: AOJu0YzWYU8X97TkauFrJgWSWy/ABAB3mGrFAw3DiOo01bHNVQ1yYYs3
	IOEH8TKNv4iTW4Q22x3GHCQ7jGRBu4NjfAHNoKOtoxOL6CrSkY61odpN6bobT0CbjxrsMZ9mbm5
	M
X-Google-Smtp-Source: AGHT+IFvpiKrSTrwIovBiT5E5H44Axlh1ZA0u5O3lSzTgmUBWQ2c6n/qIAOBLGApLdhHqgE4sr4sLw==
X-Received: by 2002:a17:902:690b:b0:1d8:d1f5:e7a with SMTP id j11-20020a170902690b00b001d8d1f50e7amr2557976plk.52.1707585668608;
        Sat, 10 Feb 2024 09:21:08 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001d932f1b92bsm3191183plg.289.2024.02.10.09.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:21:08 -0800 (PST)
Date: Sat, 10 Feb 2024 09:21:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Takanori Hirano <me@hrntknr.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] tc: Add support json option in filter.
Message-ID: <20240210092107.53598a13@hermes.local>
In-Reply-To: <0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
References: <20240209083743.2bd1a90d@hermes.local>
	<0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 10:08:03 +0000
Takanori Hirano <me@hrntknr.net> wrote:

>  	if (tb[TCA_FLOW_MODE]) {
>  		__u32 mode = rta_getattr_u32(tb[TCA_FLOW_MODE]);
>  
>  		switch (mode) {
>  		case FLOW_MODE_MAP:
> -			fprintf(f, "map ");
> +			open_json_object("map");
> +			print_string(PRINT_FP, NULL, "map ", NULL);
>  			break;
>  		case FLOW_MODE_HASH:
> -			fprintf(f, "hash ");
> +			open_json_object("hash");
> +			print_string(PRINT_FP, NULL, "hash ", NULL);
>  			break;
>  		}
>  	}

Since this is two values for mode, in my version it looks like
 
+static const char *flow_mode2str(__u32 mode)
+{
+	static char buf[128];
+
+	switch (mode) {
+	case FLOW_MODE_MAP:
+		return "map";
+	case FLOW_MODE_HASH:
+		return "hash";
+	default:
+		snprintf(buf, sizeof(buf), "%#x", mode);
+		return buf;
+	}
+}
+

 
 	if (tb[TCA_FLOW_MODE]) {
 		__u32 mode = rta_getattr_u32(tb[TCA_FLOW_MODE]);
 
-		switch (mode) {
-		case FLOW_MODE_MAP:
-			fprintf(f, "map ");
-			break;
-		case FLOW_MODE_HASH:
-			fprintf(f, "hash ");
-			break;
-		}
+		print_string(PRINT_ANY, "mode", "%s ", flow_mode2str(mode));
 	}
 

