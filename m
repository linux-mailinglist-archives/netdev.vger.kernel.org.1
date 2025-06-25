Return-Path: <netdev+bounces-201087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1510AE80DC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52198189812A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1A2BDC39;
	Wed, 25 Jun 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgOsvqz1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13529B233
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850499; cv=none; b=koHKVXcpx68ssz2h/9zlrfi1Kxel01nkFYZOQsaCtLoV543p3QJCgAMESD2wdNrnUaHV+nzfkSbRxeobUXjqQlDCBPbCLKyFdYxI1R27fGkeRubgpb7oAvwB6JqHLsVH4SWCItZ14EhEppKJwKAquEyF3sYwLQTtOtLXvZh6eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850499; c=relaxed/simple;
	bh=qgLxGX1O9OKrcZU67fvFIBl1Z1VNSzXBbr6SV0v+gMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxc/MDWh2CVGmDRrXli+YulDM0yAQgmdFiKFX8Zv8IdnvUduBUNzj1LZLA4083TYPGioaQ3bwy549LelHimfNOsdwDSz6HvPabxBU5bhTDIa4XlOmKz+U4q3XrfOfltHyMNVuY8hWr9J+f9FhqWV9tAo2nVFHKxyTqvhumgJbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgOsvqz1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750850495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgLxGX1O9OKrcZU67fvFIBl1Z1VNSzXBbr6SV0v+gMY=;
	b=hgOsvqz1m4l0H3I3UDdor0pRo1EgkV2QS1Y+c3nFVQ72OdETzec5nkvEQwuGJF/pFQq7no
	9blA/jE2htPMAYfPkTSvmjRKJDALDeBi/+Nio7XfQ3pOKjO6O7PrLQgq3qYEkdde7MC7GT
	1RLhhpqk8WtEgdf3p0u/jQe7p0C+7Ik=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-TuMteSTVMqa-bB1e4zOtmg-1; Wed, 25 Jun 2025 07:21:33 -0400
X-MC-Unique: TuMteSTVMqa-bB1e4zOtmg-1
X-Mimecast-MFC-AGG-ID: TuMteSTVMqa-bB1e4zOtmg_1750850492
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6098216df4eso804829a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 04:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750850492; x=1751455292;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgLxGX1O9OKrcZU67fvFIBl1Z1VNSzXBbr6SV0v+gMY=;
        b=KOv5n750XVmuRxEtZIGc6wtvbp5zq/RS/9ZhrGjeiw5gdqQ/7n6mQ7egLob+/bBmbE
         ec0YYTOhsh5rONa/9S3lsNAu/LaasPbAk0WXQyk4HWWQDdsTeVAxbZsY26XuKUW7YtYk
         hzUUDK69mTkeE5LBstxVLqlsJscGI1/yWQMPh5dtrRySxdCQ4bsffUyfv5VrPRlq4AL8
         ZWk0jD9+9pKGJwrrEZg5RpgVxsHSX12aCaOwmIKphMjHxX+bvY1nOl0NUMVFjMVbJfj/
         xDi1XXS6Ez8sPC0dTOHXKHPEYM29ZBR/SYUxUVn0DwwDZkMrDRbdgwdj2zcdqcAPHDLt
         uSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjjSO0yK4jtjcKAhMwfOfjxo7xoJ6NdKGqdFFlU/3e2t44O4+vRv/BFab6MIuqPVPxnH2HZH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7FJYPi0BVfdUGF8xfWIqt3ivgqUJxuIyfbWeezz5W7Cm2CQHe
	kqmDp0GvDNb4646+c80kxiC+M6I2HRnsvI5LFDA9/Olr15lCZuRnL2jkR9V3PGQ09oKmAtEBv5G
	KcDmY4/eXczr+rVqCxsuDiEedvRAWRPqY3WHJrTty+U6CvHuSP8GL9lwnIg==
X-Gm-Gg: ASbGncuD6U5Gv167zXIfDCL1UVGwoDDeqdHlJgooGB2pGhCNr79k04wTWZ/qd+J3kAS
	hjf3BOj9pvyOqYmfApSxFLjTmSzJAcqj0fVzQXloEZxXV/3ko8Gru72lPgSpFIhniVlQFYuXErk
	lruuFC6156rWLWXdG1E08cSYiRhvxNA7D4gdghkxl3az3x+JU9eN/IP6Du9R1LAhqGPH3tZgGBq
	BZvKBqMPu9DFpd2CL8JvJztiDc6AgdXte1X61yJPhRaf802ZDAtsjZKDZxy43ulffMjk3lyonPd
	kJMtsCgv9YzJXYvmW7UhLB1DXxfUt7t9r2EJKb+x995+rUiP/5ynDt6OyjWDfMPjdad3
X-Received: by 2002:a05:6402:1ed6:b0:605:2990:a9e6 with SMTP id 4fb4d7f45d1cf-60c18a46cedmr6626663a12.5.1750850492123;
        Wed, 25 Jun 2025 04:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQw4BhvqUZQ8lAfkTciuUYDStmiRDeXkvc50NH3CO1HBXCSzjsFFtU5aMUkChl5N1v+9x+Cg==
X-Received: by 2002:a05:6402:1ed6:b0:605:2990:a9e6 with SMTP id 4fb4d7f45d1cf-60c18a46cedmr6626637a12.5.1750850491705;
        Wed, 25 Jun 2025 04:21:31 -0700 (PDT)
Received: from [10.45.224.206] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196d45sm2341545a12.10.2025.06.25.04.21.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jun 2025 04:21:30 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, i.maximets@ovn.org, amorenoz@redhat.com,
 michal.kubiak@intel.com
Subject: Re: [PATCH net 06/10] netlink: specs: ovs_flow: replace underscores
 with dashes in names
Date: Wed, 25 Jun 2025 13:21:29 +0200
X-Mailer: MailMate (2.0r6265)
Message-ID: <44E2B1F8-7711-437D-8CA1-2ADF5D344356@redhat.com>
In-Reply-To: <20250624211002.3475021-7-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 24 Jun 2025, at 23:09, Jakub Kicinski wrote:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: i.maximets@ovn.org
> CC: amorenoz@redhat.com
> CC: echaudro@redhat.com
> CC: michal.kubiak@intel.com
> ---

The change makes sense to me.

Reviewed-by: Eelco Chaudron <echaudro@redhat.com>


