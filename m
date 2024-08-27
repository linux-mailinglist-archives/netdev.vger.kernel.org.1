Return-Path: <netdev+bounces-122407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDF9611B5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724901C22ABD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272E1C578D;
	Tue, 27 Aug 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsgBmy2g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778319F485
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772151; cv=none; b=KMdc0iZnffV89asLcOrjRk3MkHnW/GcShe8z8h+s4YZUui2oM7d85lQuZYaBTgmd6tsxLPCIGBiCOlf0PvDMvGo+s6rzT7l1KqRP+9572q3TFo0RE5gpIZrmQmVKVuauhbrS18q8DaAcz0ZzDGvIckOUSnJ1CFmfZ9T/F+RoMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772151; c=relaxed/simple;
	bh=465bVayaKxp7NXZ+D/CmC4N6IT94unayOyJURT+WrLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUZe6N4/TDgM5eFAlka1RGxkUxe6fq9ipnLJxPFTItsuRyrzuUONmjhoS3ePiDjPF/lvM2mLF+ygTWR8arUOR0aphpV050TkG8luaHkUrlUurO6IjPS/aAT3azB33wUrRa1Ck3d6CK1o93F0GlCVzwwQdWs6nhXhrzwfcAy5vEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsgBmy2g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724772148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=465bVayaKxp7NXZ+D/CmC4N6IT94unayOyJURT+WrLQ=;
	b=NsgBmy2gvLcV427leYP3brLYxKvShJpS5xLEZDVnqBps9qo8gzK/2gQLMgBqDxVd+YBshg
	IIVc9XVT7AuLVKWuGCyshp1wOzVa1sSOfyIWu56/yDyrMPLfNKL53/WnUfZS3OBc+b4+yG
	vX7ExQCxL/pFFWstnxoytxjPnLiDvoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-gwIDe3C_N7anOZRJN5zuqQ-1; Tue, 27 Aug 2024 11:22:25 -0400
X-MC-Unique: gwIDe3C_N7anOZRJN5zuqQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371aa2e831fso3277437f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772144; x=1725376944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=465bVayaKxp7NXZ+D/CmC4N6IT94unayOyJURT+WrLQ=;
        b=EVPfYOzIAJKgyUIaVFVy4kVg95W47kDa2bUjad3VII6SQGKUX2SqrAC+4C6G2ioxVY
         guSn1DSH7o2YNkiNU2E+mSq236tNN3FwIDWh4BSH6CJ0Bh9mBjA9+cMh2pgRCuJKsOXF
         rcAX/xBOXWwwXk/mSKKdiXgLHf391eb81RDQep+eORxn2uERA797xMjd/Nm/PUkpZ3Z5
         6VA8UbCMHG/g3naYtUztWkWFZkGV+dwnCAqDtQMRIidcVnmwTS4gGWyxfvRgK91kLjNC
         e+GUZidJgarCCsqIzBNhKsG1gVcMY3ypVCDw7QYHKFtm/AD4G4E7ksGv2R4z8z3hwn+3
         xTBA==
X-Gm-Message-State: AOJu0YwaCv/+2rX8hnKf4mtAUy/MOeHy08Ln6/jXg7sIGzLIQdLOBwg8
	JczMqyeE6E+ZphCJwf06E5RU3JZ9hcbVzce2vSF+VWeReIM6vXgZ+lcG2W7P9h6Rfez8SN5XdIx
	oU2/YIAGilagrFk5qv70NUoSeGtraOfxllZSxaVKzMDI6vJVAnoNE/Q==
X-Received: by 2002:a5d:5983:0:b0:371:9156:b3b with SMTP id ffacd0b85a97d-3748c826121mr2563879f8f.53.1724772144413;
        Tue, 27 Aug 2024 08:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTKXOd6fyR5kMod0qtqzjP4uOvprEP2k4hJcEdvOz85m+mgpImCFxD0foQYNMNiY4JmVrTLg==
X-Received: by 2002:a5d:5983:0:b0:371:9156:b3b with SMTP id ffacd0b85a97d-3748c826121mr2563860f8f.53.1724772143626;
        Tue, 27 Aug 2024 08:22:23 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac51802a8sm187263845e9.40.2024.08.27.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:22:23 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:22:21 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] vrf: Unmask upper DSCP bits in
 vrf_process_v4_outbound()
Message-ID: <Zs3vLflGfnKGRVOX@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-12-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:12PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_flow() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


