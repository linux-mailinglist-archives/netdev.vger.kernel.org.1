Return-Path: <netdev+bounces-63139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0AE82B556
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DECA28382A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE3155E57;
	Thu, 11 Jan 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZaQfr2qs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC9524AB
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4ca2fd2fbso31925615ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705002037; x=1705606837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19d4BlLYusPhYqHBHSEuyZrSTiiD3yUoLp/zgt2wYfA=;
        b=ZaQfr2qs/Whsl0siLf87Vl3fOR5bMWNdfXsK0U0WcYPfwkCLhvr8WA2TQOXfcA37KH
         YjG1lP+D1Gu6/muMaSlmYmgjxULq9o+LA74VPpin7ksRK8uz13EXTjE4j+8Eq1pH01rg
         TXxpGwXOB7YX/5ZIf09Fl18uQ9i/gvPCQre1lq/n5fReW6xYVMKZ89dZNMaGDNMCNXz3
         pnVTyblsqulHyhmSZNXfcVeGCT/Tj3JqgC/hY/bOsJsE5raTIVpCwCp1mdWYzWQ5AXUg
         pdvdiYgwfLtgX/DuNGOzfAdq51NTnPj5wzv9MIG/xr37F9jq2pXqFUA0pDHVMZsdIocJ
         apfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002037; x=1705606837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19d4BlLYusPhYqHBHSEuyZrSTiiD3yUoLp/zgt2wYfA=;
        b=p1HbWEoU9sxgxdvWdR9KToxm1yYMcPhwmHXZeZ9MDwp+/clgczlrct57EG/htxIRBk
         4b/nmcoXcHm9q6oOaDHfqmMcvgVM0oMBKIydFAxQKRByhqiBHyfW5l301Uksqi0lesIn
         3t6jpXlAEEeku+8NZ641YYbote8FnkZEom/Q8Na0uIgnEwgEDGsX5EBIKtbh+4Uuhh1S
         4jmwM9qzRjEJrG3aPvEb9S0d66xRgIUboAk8QbiJc3cFca+EiR2ih7AE9R4f1twqIFsI
         oA8yZDUuJSc0WkgdnyGaRjgmLGABmkY/ZUtwhdpFBOLWGgnJQcWYbKelS/WJAkzJOczn
         E6PA==
X-Gm-Message-State: AOJu0YyPGgM2gUKemT8iub+I3QQrl7L+GD9p+bfIq5Ue1CqmYDCNP8UG
	CgnwZR14c0TnD2BNJSM2ah6ddQ8IH+EC/A==
X-Google-Smtp-Source: AGHT+IF5zMEJOlJHHCSsD8Hr2hRd4hym49LHNbsOruJDkqOfdgFG1n0S2oaLKYA5sf91UTZAPLQ4hw==
X-Received: by 2002:a17:903:130c:b0:1d4:be64:263f with SMTP id iy12-20020a170903130c00b001d4be64263fmr189050plb.120.1705002036959;
        Thu, 11 Jan 2024 11:40:36 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b001d536a910fasm1529028plb.77.2024.01.11.11.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:40:36 -0800 (PST)
Date: Thu, 11 Jan 2024 11:40:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Jon Maloy <jmaloy@redhat.com>, David Ahern
 <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 2/2] treewide: fix typos in various comments
Message-ID: <20240111114035.4dc407dd@hermes.local>
In-Reply-To: <f384c3720a340ca5302ee0f97d5e2127e246ce01.1704816744.git.aclaudi@redhat.com>
References: <cover.1704816744.git.aclaudi@redhat.com>
	<f384c3720a340ca5302ee0f97d5e2127e246ce01.1704816744.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jan 2024 17:32:35 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> diff --git a/include/libiptc/libiptc.h b/include/libiptc/libiptc.h
> index 1bfe4e18..89dce2f9 100644
> --- a/include/libiptc/libiptc.h
> +++ b/include/libiptc/libiptc.h
> @@ -80,7 +80,7 @@ int iptc_append_entry(const xt_chainlabel chain,
>  		      const struct ipt_entry *e,
>  		      struct xtc_handle *handle);
>  
> -/* Check whether a mathching rule exists */
> +/* Check whether a matching rule exists */
>  int iptc_check_entry(const xt_chainlabel chain,
>  		      const struct ipt_entry *origfw,
>  		      unsigned char *matchmask,

This is no longer in current code tree.
Please rebase and resubmit

