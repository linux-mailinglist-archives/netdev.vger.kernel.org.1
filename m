Return-Path: <netdev+bounces-71024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D783851A4F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95371F23383
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213773CF68;
	Mon, 12 Feb 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jNxA706j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695273D54D
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757157; cv=none; b=KsNhl1h8MhwF8AEHhimbX/aJGpWpjUNJRsz4nYVp2lLxbR+e+MI33BTU9YJKm7zjdygbaibVU0upASUIsjqAgwhBRBTrOaDKgVV9Ru/mUkgTJwT8nUA3jstP4zX9eqO5Ht1XBgD052Y7XDDVIyt/iJPGWRE33gI74qAry6l9dAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757157; c=relaxed/simple;
	bh=//3avnBiQp/N9LeHWX8gVXUCCHlcVDDmNm/ZaO4B7wE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJyFE4pVIRQ6/+HTF5G3Gu25ySH78Q4azBvRjgBWtk8fYyzq+192vgye8GwXs/7A6QOOqY6syF2ooqG0t0bJyB8L5w0LM90g19yvi9a4ygJVbma/8wCU/jYesmAaGd8qSilWHXOUo4kykMAA0rFg1K+gbqrUejQDOO64M0GLbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jNxA706j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7354ba334so29206945ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707757154; x=1708361954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF6CT0fKrtPvE5PdMA36wyep+ZdjbIUTubrn6/QOkFQ=;
        b=jNxA706jfcFYnx76WSqd++mbtKyx/XNPIupLg7/0eqa0uixMCOYYVT2CL27MTGn0I7
         w6Yv/GM0MSdKxzbSHZnElIuxyZDP/5IauMLQUBz2kBfXOFHK+EgtM+0A9YX8Q5QPKQ+W
         eoY093pFHzXkcQR9aOMt+YLxiAmf6yGYQL5n41JsPITIaCAC6AR5zRuJ+cxUfcc22U7b
         JhTUcQo61LEeMupmXKjTDbcfNnODw9kTf29UvV06yYtC6zFsW+tWYPWQ2xF84x32y9i5
         ZCgdJT2zKlEOkuj9gtudkPSui1sne3pJ27vpriDWsxHkxrneslmYpDoYg6NoyTs1t+DR
         r2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757154; x=1708361954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF6CT0fKrtPvE5PdMA36wyep+ZdjbIUTubrn6/QOkFQ=;
        b=N8oG90Thf/w62JTNiG7oOD10wbV+i9yEuvLg/aktH7W33Z05CG3O5lW7+Nx8b2cwcD
         f57WUh4ZpZmhG90QyhD9repFb89mlGWT6UZH7RHsh2WAVI1s1r+k4hJH9Y2KDF5qrFP0
         RuTrFF6IJV1Z6bcounIBAVl/lEF682tPlUxP8muKgm+0DFyfFFhMhGcr58HGUilJVClH
         pMAIAly+c7P8a3x9vgI32yTxSfivMhj6OW+PaxpqHOdrfJBUAaHbUKev/ixKciFhGXTA
         7vhi5ci2Yet+cfwUZYzuAB7e5gYMCCYRaPBRs5wI2A4jp0GCjPlATQxgjh5IvezLNvdH
         eFGg==
X-Gm-Message-State: AOJu0YzpgAyU/Q8aZl+jYrhJ1itI11yaU1pcIF9s1LN5UBm/m8T/rgZG
	Pa1GWi6pUTJBGt8/tmqrZWcSqjxlfU6RWwIErKTReEdKL6CtKZJoHupaKgMqviM=
X-Google-Smtp-Source: AGHT+IEJzQfiQdfoLTzDc7ypdVpKRi6VkEJlGwKmr04ouMw4UziOL5Nt0lxw7Im2Fp/4maGlqdvGKA==
X-Received: by 2002:a17:902:e5cc:b0:1d6:ff27:7627 with SMTP id u12-20020a170902e5cc00b001d6ff277627mr10034617plf.50.1707757154667;
        Mon, 12 Feb 2024 08:59:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWl8rJlqFKEy5dPu1DMhUJjJ8IRlWcIHoXWoBjUGL3dJStU6vLcsHwqyBCU7Jos14PHQRiYU5KNlMa7mZCHcRHR4QdlUUjwuuFWB2KlR0Pv0hy3QlR+mm/buLbSsO9GaoDIvrj2CNxSateFZzTBUwbLvQx1fYgellulWcX3g3lqVi4R
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903004d00b001db28bcc80csm585046pla.74.2024.02.12.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:14 -0800 (PST)
Date: Mon, 12 Feb 2024 08:59:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@meta.com, Matthieu Baerts
 <matttbe@kernel.org>
Subject: Re: [PATCH iproute2 v7 1/3] ss: add support for BPF socket-local
 storage
Message-ID: <20240212085913.7b158d41@hermes.local>
In-Reply-To: <20240212154331.19460-2-qde@naccy.de>
References: <20240212154331.19460-1-qde@naccy.de>
	<20240212154331.19460-2-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 16:43:29 +0100
Quentin Deslandes <qde@naccy.de> wrote:

> While sock_diag is able to return BPF socket-local storage in response
> to INET_DIAG_REQ_SK_BPF_STORAGES requests, ss doesn't request it.
> 
> This change introduces the --bpf-maps and --bpf-map-id= options to request
> BPF socket-local storage for all SK_STORAGE maps, or only specific ones.
> 
> The bigger part of this change will check the requested map IDs and
> ensure they are valid. The column COL_EXT is used to print the
> socket-local data into.
> 
> When --bpf-maps is used, ss will send an empty INET_DIAG_REQ_SK_BPF_STORAGES
> request, in return the kernel will send all the BPF socket-local storage
> entries for a given socket. The BTF data for each map is loaded on
> demand, as ss can't predict which map ID are used.
> 
> When --bpf-map-id=ID is used, a file descriptor to the requested maps is
> open to 1) ensure the map doesn't disappear before the data is printed,
> and 2) ensure the map type is BPF_MAP_TYPE_SK_STORAGE. The BTF data for
> each requested map is loaded before the request is sent to the kernel.
> 
> Signed-off-by: Quentin Deslandes <qde@naccy.de>
> Co-authored-by: Martin KaFai Lau <martin.lau@kernel.org>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  misc/ss.c | 262 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 259 insertions(+), 3 deletions(-)


Some checkpatch complaints here.

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#123: 
When --bpf-maps is used, ss will send an empty INET_DIAG_REQ_SK_BPF_STORAGES

WARNING: Non-standard signature: Co-authored-by:
#134: 
Co-authored-by: Martin KaFai Lau <martin.lau@kernel.org>

WARNING: line length of 112 exceeds 100 columns
#189: FILE: misc/ss.c:3417:
+		fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",

WARNING: Block comments use a trailing */ on a separate line
#286: FILE: misc/ss.c:3514:
+	 * a socket, no matter their map ID. */

WARNING: Block comments use a trailing */ on a separate line
#304: FILE: misc/ss.c:3532:
+	 * to avoid inserting specific map IDs into the request. */

total: 0 errors, 5 warnings, 344 lines checked

