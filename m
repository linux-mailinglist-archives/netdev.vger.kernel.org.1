Return-Path: <netdev+bounces-145050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C69C9368
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032A228281B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE85198A0E;
	Thu, 14 Nov 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9iOQYgw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F92905
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617371; cv=none; b=e5cwtMtf6G+yYrpKTyVp2/CoRfVmJ68Fwil4y46eEVw2hfdscS4/omqeskmYa6KgOqoyPyFkc/Unfx8pW3lvgb1AFo94B+lvBNQwREZ/9OmxIj3iPKAt9H/rKKuYBzKnvaADxl5X3l5fLVf85o4pMZT/MkCwcWzkldQVWTRMXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617371; c=relaxed/simple;
	bh=SORhfgP1AmNA8Ku3GBBL2c1Pyc4BKJP9d7oggUwQT04=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OpDzHLs0vSo8qAEnQbvRPsgX2VBNkbeHKttc4l8ScqmFSFlIzFsqu/rKNFW2yqjpmZhsGdCMxxS5n/EJzzTluQhTFvsjrk1/97Bbkgw2iNMdwAXpgA3cafIl4DLHjeU7inZUP1kXLzksyIo0dgiZgB94Yi6f49CXo1Wb4m2Mwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9iOQYgw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460d2571033so7246151cf.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617368; x=1732222168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzenMFjGmiLUkDNkOxhhX9ZG8CaN7dCVomk6HWyYk3E=;
        b=Q9iOQYgwn6mfpek3TE8DnDITcz6eaFvY0PYjK8UI6D8YkW0sM3Rn7LzQaUivhCbcj/
         oaIironp0C+Oi6kFSTEMDeH8GIqPCRTAAY+LU9Kb6lcOeu+wBsORDsNu3DtMhg34y51p
         c4BJhaoCCDLg1SlmfiZEHFc8dyFze0yqr/FScYlRs8HQkuEVpgtAaH+I9jdZUZX224SW
         vomN6ZRoeWeQSjzKIHCi6iH+fYZ/KQUDxrk9NcdHQxtq1e88FGsjG+qjMFa9BnsLWPb5
         aughZ/rmYEQMu0UcF8kcm9ovCY26LF8g87AT4eXUmoPi5hs73434iLCw5v9O1Msmruj2
         nNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617368; x=1732222168;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VzenMFjGmiLUkDNkOxhhX9ZG8CaN7dCVomk6HWyYk3E=;
        b=DBj/GfM6Lsd4dJYWgGMFms8HQKmRIKZTqY9ngVgBbP0XAfLFeylfx3IHbkR7jwhgPX
         uijTClwR3W6rFeS3RuYPIPqT0v3vOSX5KUeMdQR0Y2isB/773VlFOH0/lQ2zoPZ2FI05
         d91JScvglrr7iZ/ZlqTpYF58Zmd2UZVENOTymLCnW9MLg1nbrqSGJf3md6jtBxsMr00N
         sQs93Mkobaj+PV80FPEQAvhi0UhrwmD22nkjzr6i5wrQxvmO4rCwOb9MAvgRSphmkx1Q
         uFlC5Z3+U6WMyLQtiPNBGZ/BRGB/W6/DFZIFUWagMPoarDczIVh1NOK+JRXofGyl9Qev
         m0Mw==
X-Gm-Message-State: AOJu0YzzctgO1vZsr8VnN/R+tBaedsl4wRtXpcfl73I+u8vOeb0PznLS
	iFEkIvifUJpxWBRvdP/XyGtM5kfke36QeRgNIe0ScrpaOIYuXyGOSHXvSw==
X-Google-Smtp-Source: AGHT+IFjZrZFMHfmtwPufHCrAtncZ868BgfSdkzU4TmreVHdLrdN/XZXvaTBRQMH7iXh110geLUbxg==
X-Received: by 2002:a05:622a:355:b0:460:bb95:5934 with SMTP id d75a77b69052e-46363e3d376mr3177471cf.32.1731617368484;
        Thu, 14 Nov 2024 12:49:28 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca30777sm88473085a.86.2024.11.14.12.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:49:27 -0800 (PST)
Date: Thu, 14 Nov 2024 15:49:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <6736625792e20_3379ce2948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-8-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-8-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 07/10] idpf: add Tx timestamp capabilities
 negotiation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Tx timestamp capabilities are negotiated for the uplink Vport.
> Driver receives information about the number of available Tx timestamp
> latches, the size of Tx timestamp value and the set of indexes used
> for Tx timestamping.
> 
> Add function to get the Tx timestamp capabilities and parse the uplink
> vport flag.
> 
> Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

A few minor points. No big concerns from me.

>  struct idpf_vc_xn_manager;
>  
> +#define idpf_for_each_vport(adapter, iter) \
> +	for (struct idpf_vport **__##iter = &(adapter)->vports[0], \
> +	     *iter = *__##iter; \
> +	     __##iter < &(adapter)->vports[(adapter)->num_alloc_vports]; \
> +	     iter = *(++__##iter))
> +

Perhaps more readable to just use an int:

    for (int i = 0; iter = &(adapter)->vports[i], i < (adapter)->num_alloc_vports; i++)

>  /**
> @@ -517,6 +524,60 @@ static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
>  	return 0;
>  }
>  
> +/**
> + * idpf_ptp_release_vport_tstamp - Release the Tx timestamps trakcers for a

s/trakcers/trackers

> +/**
> + * struct idpf_ptp_tx_tstamp - Parametrs for Tx timestamping

s/Parametrs/Parameters

> + * @list_member: the list member strutcure

s/strutcure/Structure

Please use a spell checker, don't rely on reviewers.

Also, going forward, IMHO documentation can be limited to APIs and
non-obvious functions/structs/fields.

