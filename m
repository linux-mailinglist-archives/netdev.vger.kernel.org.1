Return-Path: <netdev+bounces-122404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12B961176
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3151F21E22
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0521C86F6;
	Tue, 27 Aug 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLKG2Nf7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0C1C688E
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771971; cv=none; b=l7SxTfp0h0mYby6hkCR8lm+RArvoiNZgOmazpVL87DTqs77eucdJAqxX79re0mEa6T2PZmstQ0zX7/99EtWaUngRRdGzXgmFfUqYe82BG+8q+ujP8JGYc11v96wtNuVy8q426luPQhJywYO5O/FPpxesQQaEHghPPVdkj4/GgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771971; c=relaxed/simple;
	bh=XsXTgyfX4lK8uIlF+JZT8a96CuV8addTsgcuxyLMIXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM9c1n+VEVhELF60MZflvoUW8tui/n5c6YxMyLifjBelr8EFcgSQxTyNoOU/seYu9UEAIz3VB1mW32YsJUwwTKcdjwtwfRsu/w4Ju/7v06rjfmiBV/Qdk3p8plJGUKxqrL9fsvK+pGUQqNcpVqRbMB7msn0bALKEZPG7z/Dbf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLKG2Nf7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724771967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsXTgyfX4lK8uIlF+JZT8a96CuV8addTsgcuxyLMIXg=;
	b=NLKG2Nf7I1oY1D5Lf5OgqR7eHpjWHuj84kdWBhLwQQA55sliz5+EEZtGEhoeeVyLWgXNI3
	9i7/nqtztFXU/7knGzHzCJQQRpbWg+qqVQLcPzDqV66JTttXkzMBCGg/EPZz8nZy1j05cc
	k+vOKatstZo/g6zB5Nj9JAPSHkfXYyk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QcAFmtw2OjaFvTEvgJh0sQ-1; Tue, 27 Aug 2024 11:19:25 -0400
X-MC-Unique: QcAFmtw2OjaFvTEvgJh0sQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428040f49f9so52918145e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771964; x=1725376764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsXTgyfX4lK8uIlF+JZT8a96CuV8addTsgcuxyLMIXg=;
        b=OiSJHjJyaeikJ5apfkOS9w7yIY5wlV3F99K85+G7J7oU35uaeqHxEB+sLtCNYpmCcq
         VaJ4DimxOLoAiqjN0mz+oxmFrQWXqptOUpwX4e7bjUzN/6FvrZPkSbjo5P36tmG8S4wf
         kuBHEkXhWZeGU7gAKtQIYcXrKRSn7g41rD7Tcqsb6QXIEGGBxLTDxBofYPIArI8IiR1o
         TOoSG+hlQsiKR30FfmXiuEglTSy0Ikh+wdapXYu975Z59Cu6rcgzAzLD1Yh07ecQQ/II
         VKB/k1ZZO8OYxS1upe/dwQG2BE5yfN+oH2StjGWE1WQ2XaeanPPUm61cMMZgcW0NW1kx
         PzcA==
X-Gm-Message-State: AOJu0Yzw6lk3yI7qhS8KPf/Bu8b0hO6uPB+eDuRLBS7yhDQ9FfNpzsTz
	e2iJx2CJW6KhLRwltbRrsBHxnE+hcPubxsQKpYL8NpDoeGtB7ndkJcJXQgxlOcRPdgoIgi4lYYv
	DaGf+8WM7hCrbmA4EZ/NAIEhYnVEPdU8pMpy2rOGAIrpXOqMchL+vDQ==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr20766265e9.35.1724771964527;
        Tue, 27 Aug 2024 08:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVs7Eq/Lgx0Ec3DmzVYMcg2muWndP6suW1Qn92j1nPKb5gJ8Gdf9ACQzJ78fT4mjD/JVG01w==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr20765965e9.35.1724771963838;
        Tue, 27 Aug 2024 08:19:23 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeffefcasm229538755e9.45.2024.08.27.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:19:23 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:19:21 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] ipvlan: Unmask upper DSCP bits in
 ipvlan_process_v4_outbound()
Message-ID: <Zs3ueeXcqw47HXa4@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-11-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:11PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_flow() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


