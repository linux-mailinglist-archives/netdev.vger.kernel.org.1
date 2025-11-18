Return-Path: <netdev+bounces-239315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD9C66CF3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B34C84E1D09
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A902DE714;
	Tue, 18 Nov 2025 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG/Bf40x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575F78F3E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428498; cv=none; b=hS+YERLm5BE0ng28HwFookPYyVr87imW9BwkZZpiuMZePV2YgmDSyfoBZHWJp9mTr3Zs4mcwDcAylGtD32ldA+BFcAfvBjFnE2f62hjmSLG9aPahn8qFPTQ78mX3mh9twlY79WHXEu0gQRX20+ORJD7PzDFFApp9Ot5/IvB2X9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428498; c=relaxed/simple;
	bh=B8FPsG2iTjGgTZShq08KHEhShplT20vB77ij2RSOGPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+ciHxBM9t0pIpGCfioZiq4PqYc+ojdzcbQCzEBioaKxv1BhlD+mzYHkHCoit2ELg8rRqeACTipU5QHMcPSnPcpwzh6X16SZNGMWohKVwfRHhIuLCAYulrlC7+GKJ0Z/DVpVFw0XjPdH5UVwCc3bRCS2gkS3y16wZVusSoeqt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG/Bf40x; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso3579194b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763428496; x=1764033296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHC2r0l8d3apWOKncTvZx9/DVHftVDRN6D3AppqIw20=;
        b=MG/Bf40xsQdRwdS0cnle3dQ80nsKPnrRnsUO6V0xxt2HjlZuc04F6R500b3dZqSjvL
         r23k0xa5MXImBXxKDNVx+zDADh+WnY0lbPX30HiSY4ewL2f1cXLdSs/TCV3vNyuDE4Yj
         sojMO/kNZFazOLpbTLiMneFdxu/DWJizAdTPk4Go9IKu2s+mM2q6rOeiU/5V3i4ruC0M
         ZlMCIN80r14TFcCQW+mOHrjsUO48yDCyHT7MgjkMfZnQczXrjiLoTLvBTpooXGmQgBl+
         esBsF/8d8F/WjxKBG/8zpfo5diMXowcsNO3FqgUT2F1279iwKb/VRTusdKRvyiSItP2N
         Czxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763428496; x=1764033296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHC2r0l8d3apWOKncTvZx9/DVHftVDRN6D3AppqIw20=;
        b=MdJpvBpVphgb9Limdd9PEyvf1iSQ+7nQTtvgJYeUeQaJGWBXztZJwodKTPHfxXM3SI
         jrVQlshlon7lk8X36twXpXbtrCztFNWmw1wGvcFv+Hx/jOjZq04lqxXJp+rnSadflQlq
         9pKHP2cAtRfpSe3hFnntRUVJCBLBeH6Jr09ltyzdG/tImTkV+4JRdB3pMrBw0lZ/hmdX
         wm/CL7osfNK/WHmz+vFjRK2JkCrhdH3pPlWe4O8oq6fmBO6UzxU5R+4mkrE/XavqW38H
         J9HnXMzxP0818tgBVxu2dxzsriebcXmNwFoscOLVB79cieWjZbvip7C8ElpxKiyxqjDD
         zwNg==
X-Gm-Message-State: AOJu0YyT0DML0+VP2vG2K8id/KdoKqjQvSnAn3qcSCyBWzzhqb6x+mRj
	8f1rfp18IWmNJ4djov1YvzOZzTxCHL7jiAf8AbtJR7wc0vKby4ngRstY
X-Gm-Gg: ASbGnct6wlIEY89wrj5BWx18U6WAqq+3trEPPYhojwZAtd/zH8MtfuzVSoWGgH0c+N+
	53e9JMnwteavv6Ks8X77Ozd6+cWXmWTJOPNieH/ZZI7YWxTuR20QpdmhNS6wOZ+8UIke/6l8U3a
	laqIERdijtAFNQbUxvnLOSjBTuIz4H0HyKpxBR0QFP9lom8iPtxecnQ8Ui3Zg/aoebD0iTdOnZn
	TYo30Y9S4fS8jGeuTf+K96bOYTVQ6PiwOjiOe9ViX8Ykr/xOTTKpKrRFLG+LpK7Ci2KPVDBOVzI
	RugDymrFkc5k0jsI1GtRoK7Tv4sOwqVEh5lE2Dd7Wv6sTV0WSwVEvK6kH8KnYUy2EZreUKpK91q
	LhbxIeQtK9fBxN4pgIZCCU657fSjulGQNGDlBdWgCnpoYFjvh4+vV4OiA745UxyhrmPdvf9moa5
	QYKvrzWlUTBxTaHuE=
X-Google-Smtp-Source: AGHT+IEpLBOkGpreCFNoWg2ysNV5W2ggBSYSmFAWy1grwXJIxkrRY9j/0WWOMXbKZdpMSWxW85beFQ==
X-Received: by 2002:aa7:8890:0:b0:7ad:1082:fdf0 with SMTP id d2e1a72fcca58-7ba3da12ee4mr18328643b3a.31.1763428495904;
        Mon, 17 Nov 2025 17:14:55 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772fa51sm14484966b3a.58.2025.11.17.17.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 17:14:55 -0800 (PST)
Date: Tue, 18 Nov 2025 01:14:47 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv5 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aRvIh-Hs6WjPiwdV@fedora>
References: <20251117024457.3034-1-liuhangbin@gmail.com>
 <20251117024457.3034-4-liuhangbin@gmail.com>
 <b3041d17-8191-4039-a307-d7b5fb3ea864@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3041d17-8191-4039-a307-d7b5fb3ea864@kernel.org>

On Mon, Nov 17, 2025 at 11:59:32AM +0100, Matthieu Baerts wrote:
> I just have one question below, but that's not blocking.
> 
> (...)
> 
> > diff --git a/tools/net/ynl/tests/test_ynl_cli.sh b/tools/net/ynl/tests/test_ynl_cli.sh
> > new file mode 100755
> > index 000000000000..cccab336e9a6
> > --- /dev/null
> > +++ b/tools/net/ynl/tests/test_ynl_cli.sh
> > @@ -0,0 +1,327 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Test YNL CLI functionality
> > +
> > +# Load KTAP test helpers
> > +KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests/kselftest/ktap_helpers.sh"
> > +# shellcheck source=/dev/null
> 
> Out of curiosity, why did you put source=/dev/null? It is equivalent to
> "disable=SC1090" and there is no comment explaining why: was it not OK
> to use this?
> 
>   shellcheck source=../../../testing/selftests/kselftest/ktap_helpers.sh
> 

I got the following warning with it

In test_ynl_cli.sh line 8:
source "$KSELFTEST_KTAP_HELPERS"
       ^-----------------------^ SC1091 (info): Not following: ../../../testing/selftests/kselftest/ktap_helpers.sh was not specified as input (see shellcheck -x).


It looks the KSELFTEST_KTAP_HELPERS cannot be statically analyzed after
variable expansion.

Thanks
Hangbin

> > +source "$KSELFTEST_KTAP_HELPERS"
> 
> (...)
> 
> > +cleanup()
> 
> Note that with shellcheck 0.11, you will need to disable SC2329 here.
> But NIPA is not using this version yet, so no need to change now.
> 
> https://www.shellcheck.net/wiki/SC2329
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 

