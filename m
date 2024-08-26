Return-Path: <netdev+bounces-122069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FDC95FCC4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B117B218D0
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7919D88B;
	Mon, 26 Aug 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WJZ3qFsE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421919D094
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711358; cv=none; b=O5RqmrDGf6AK6aHdYy8FiUlvPdZ3qIn2unjisOb6AElSZeV+jrOMVyN6oh0mjEDqP0iom1HdOU9WpQyJvxXblsLivERnpyVNsLDj72sK6fLMFYikSbF/urijL98vv9GnUs4ppkT1lmwGRsZCTjsuliOxItGK9DO2Nl+sWKuxMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711358; c=relaxed/simple;
	bh=NSc4Okt+VC5KhhcI4GjwMNyiCG8ff6DKOAXyZDKWKwg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=kMiXJGRRRzXBK05SknC11kk8lFw7UlMF/f+i89/ryvlVLsg0aLwQ8uzQX6SQeSzre6Hftdu7fQXiixmG1YyLz8VTLh++am30YtW/NCySmFTirI1RIWL9/bJE4BsHjRk9Cny9YuYt4jwgoBeCIbJw9XlVExnJ8O5vTM2PGVr+Vq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WJZ3qFsE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d6f47112so330285785a.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724711356; x=1725316156; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3N09dlUeLDWnGTOZ4n6d5/3QJlaJZT1Youw+FJ2C4po=;
        b=WJZ3qFsEJlCOjjVv70lDYOGCojujLiMZFHAc55qUEIpvOwN6zAUz/oyCLv6nTn2gva
         v9I8lO2w20KUj6tsgMpBIWCggmiswdcrYqhr0RNXSoVFhvtiWmf0IjZk1JMAjhVBVShK
         4E4FUzp1y9VGo6ylEKDpsUIQEntHQuD8OBsKgg5fCDnlr2nm4YZH8TK19Pk7owAwU3GY
         6prh89062RpF4CDYIyQ1T92O15fGO1y0A8/mf5aDeGHYyV81+FHGrdRHHrRg+9gNa6Km
         gFZc/+NKvrIqRf2wOewBb6uIDACZnnDD7O3bKHBEhqJMQgAFWRUFxqEvBGl+a5PrSlRa
         JaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711356; x=1725316156;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3N09dlUeLDWnGTOZ4n6d5/3QJlaJZT1Youw+FJ2C4po=;
        b=t6x8UAVJlxmqFPtAlITJu+O7YwbCXHu9BE1eqAORSuwcbPzjsh5qpGKuTsYJPWwzZc
         +YXx9GonTIVN+l9wBkHAYxmCapCO5BB0mx8vKZV57Bnws6cZSGE9emOzu1JyzEF3iuQw
         49DabHY3gh+nhCQUDSFoPGVEki6lYRJNfRHy8oZdtfuL/lh05nztEgbf9Msp7nloHmvw
         R3JpcjkiZiEtdzhDAJE2j+XkOmJkyoOdap0ErFFgvGxm1nA20ljqo4Jg9p70zzCrZAk3
         MK+fYPxkl+4c6m59TFhime9PcCcf/Q4FKvhOLEoFqsd49Pc2vCiobgDU9rMCwe+rgSxr
         rmuA==
X-Forwarded-Encrypted: i=1; AJvYcCXUVULubztKT9Hduk5+F/kp/t6DkDx6BPNoDWPEd1mMfT9bm9qiRT6RMrK7Q2XTsSVcmKpbELE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy89YF1hwnAEcxWwBRt7ihikCKJGusxX/5q5k2B6iHE2djmFrq
	g54DfooRG6VdExXl8LhsFao68gZvDq+f2LhifUp+rhzVihN5cQeND72L+iQ9vDm1kKKkLuzaYII
	=
X-Google-Smtp-Source: AGHT+IFQn+z4i4PvF96htJxu0pzdb+NNPCs7QRfIEw0WlBnCJXtMyEadU8DR0+0TjKzAkjXI62fJtA==
X-Received: by 2002:a05:6214:3c98:b0:6bf:95a7:e230 with SMTP id 6a1803df08f44-6c32b8094b0mr11868556d6.36.1724711355689;
        Mon, 26 Aug 2024 15:29:15 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d27bsm50635416d6.7.2024.08.26.15.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:29:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:29:14 -0400
Message-ID: <a769ce9fc949c03f91a4ee1d1cc6ebf6@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: Xin Long <lucien.xin@gmail.com>, Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, linux-sctp@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: fix association labeling in the duplicate  COOKIE-ECHO case
References: <20240826130711.141271-1-omosnace@redhat.com>
In-Reply-To: <20240826130711.141271-1-omosnace@redhat.com>

On Aug 26, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> sctp_sf_do_5_2_4_dupcook() currently calls security_sctp_assoc_request()
> on new_asoc, but as it turns out, this association is always discarded
> and the LSM labels never get into the final association (asoc).
> 
> This can be reproduced by having two SCTP endpoints try to initiate an
> association with each other at approximately the same time and then peel
> off the association into a new socket, which exposes the unitialized
> labels and triggers SELinux denials.
> 
> Fix it by calling security_sctp_assoc_request() on asoc instead of
> new_asoc. Xin Long also suggested limit calling the hook only to cases
> A, B, and D, since in cases C and E the COOKIE ECHO chunk is discarded
> and the association doesn't enter the ESTABLISHED state, so rectify that
> as well.
> 
> One related caveat with SELinux and peer labeling: When an SCTP
> connection is set up simultaneously in this way, we will end up with an
> association that is initialized with security_sctp_assoc_request() on
> both sides, so the MLS component of the security context of the
> association will get swapped between the peers, instead of just one side
> setting it to the other's MLS component. However, at that point
> security_sctp_assoc_request() had already been called on both sides in
> sctp_sf_do_unexpected_init() (on a temporary association) and thus if
> the exchange didn't fail before due to MLS, it won't fail now either
> (most likely both endpoints have the same MLS range).
> 
> Tested by:
>  - reproducer from https://src.fedoraproject.org/tests/selinux/pull-request/530
>  - selinux-testsuite (https://github.com/SELinuxProject/selinux-testsuite/)
>  - sctp-tests (https://github.com/sctp/sctp-tests) - no tests failed
>    that wouldn't fail also without the patch applied
> 
> Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Acked-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/sm_statefuns.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--
paul-moore.com

