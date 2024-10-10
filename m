Return-Path: <netdev+bounces-134422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BE49994FE
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8311F246AC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E301E47BE;
	Thu, 10 Oct 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K449DHqw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E041E2839
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598476; cv=none; b=ZuUyQWUef/yLI/T+riVQM6Z/n8DNF7IHTf5mUVFizJRjnLdsPQCp/Vqi3xFUPnCxFskV6C7kklVV+4H9crio0pVX2ffPulNOmQZtUEQPcNtSaK+txf4W3HbJxdjsP77PW6UxDDkSgjYguJejTLPHVh566CfBkUDdaVFt8WMOwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598476; c=relaxed/simple;
	bh=ZzNf5A/0J+0V4C19gOFGD0qp2Jch/4Ikij2p/K6SY0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfwyJd3MYujGkaz045mDx5Edt5qek3h++DuFCBLGxBFwXbi0T6jhK/2/tcz02DdR0LRHSPZCMIc/WilbGf4BFJFd70RusW7RS5hHjpB9XCTBDuxr/sENKpNAAeKAtljGHIoTRusmcsO6I+gJt2ivpZO6XMHS0w4GaGKW7EVdqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K449DHqw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728598473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzNf5A/0J+0V4C19gOFGD0qp2Jch/4Ikij2p/K6SY0o=;
	b=K449DHqwFQ3s/xPca91CqEgF37Z1Ej3lTJsVzPcA8v978aghnpXX7tMQlfwYNuucxDIQYw
	UovplHP/QkWiUUyHYks3tOFGh8SbjA6R4htXr4gnNLBF5yGsAPFGqqN4goWN9OsE81eyqr
	2oEjPHpCW99l0sJ7R6NbBKi/nYADaYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-zbwRr-A-NbySKkzowDA5ug-1; Thu, 10 Oct 2024 18:14:32 -0400
X-MC-Unique: zbwRr-A-NbySKkzowDA5ug-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431177f2bb3so5616385e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598471; x=1729203271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzNf5A/0J+0V4C19gOFGD0qp2Jch/4Ikij2p/K6SY0o=;
        b=jk9H2TSjiZ1DFL5XKk9rWBbqex871wkdKRiSmaC1vf8wflXG+XI2alMI3Scmmh9Mi1
         CniMIWoBCjvL0ejOqOvpdSO6kSXU9tIrQI9GKY+0b0KIPESQ0PiUdtE+eWXPKBBFEjaq
         rhb0H1gbTPsttLLGb8YtbWr+E9qT+bI3R7NBJogP6QcoOb2Zv1CkC6cs/wXfJ33gH5zp
         G2QUpeN/ePHeEPh32f7G/NN2KK0eoSZqYQ3V9wGOKgQJ9qJYaUS+SZoFF3Vpr1OZFu2Q
         b8MDTXdFQmEkOga8CN1LfLZSVlSfjrVzzHjJ2sonYFgGr/2RQSjGvgu4HuQb9PF7Hhzi
         23tg==
X-Gm-Message-State: AOJu0YxmSk/hqJbPRf9Gzs4pBTSata+nu1ARYcf/qEvUl7v0eu/4t2Mz
	9hxyh6kfSjemiITE+/gypkm8PGxNaj/MVbThfSN0EAMW4b1gDNKYbto9ux1Cer+7jPqMFH+08/C
	XzI+nZbGOof4e1meF0o/sYZ5KTRpPmNRpp2B1uWjOkHL5kQbmTWq1OivnYT2aZQ==
X-Received: by 2002:a05:600c:3555:b0:431:11e6:d540 with SMTP id 5b1f17b1804b1-4311deec1e1mr3008005e9.17.1728598471229;
        Thu, 10 Oct 2024 15:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe+dlrc+n8e11J9bnpoU060KBU8jayDo4stiAbxpX8nGmvzfxufek04W0vfAO6SyiS4psHrQ==
X-Received: by 2002:a05:600c:3555:b0:431:11e6:d540 with SMTP id 5b1f17b1804b1-4311deec1e1mr3007945e9.17.1728598470869;
        Thu, 10 Oct 2024 15:14:30 -0700 (PDT)
Received: from debian (2a01cb058d23d600a14c4a1c8a7913c2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:a14c:4a1c:8a79:13c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd3e7sm2454475f8f.39.2024.10.10.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:14:29 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:14:27 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
	petrm@nvidia.com
Subject: Re: [PATCH iproute2-next 2/2] iprule: Add DSCP support
Message-ID: <ZwhRw/75XPPfi8Cm@debian>
References: <20241009062054.526485-1-idosch@nvidia.com>
 <20241009062054.526485-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009062054.526485-3-idosch@nvidia.com>

On Wed, Oct 09, 2024 at 09:20:54AM +0300, Ido Schimmel wrote:
> Add support for 'dscp' selector in ip-rule.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


