Return-Path: <netdev+bounces-149534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB359E6248
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D71282A40
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670392391A4;
	Fri,  6 Dec 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAVGt1tq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B11DFD1;
	Fri,  6 Dec 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445194; cv=none; b=KNIirBkaU0nZN7jDL4iVHzrAo90aSrn70PEquPB+2mAqs9+EgqgsIHy7ckzOveq2o14RQbYFdaX74IJiXVxPfjEiMUVLnonqfdY2ycjDFcehKpLw9vjJg0aZ9qj5zHkWIyHeT+ik5AnFzmrQEqhMv3CdDH/zy8IZed3UfNF/0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445194; c=relaxed/simple;
	bh=oS5NCBYgIe5Rt3oU0o0kyzFCy0yCQTCK5DGI/tTJOac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qp8v9EAxqNDsoELs/n19+7wgXu32yqYSkgH/ZqAaRSQAP1ZKrHWE7eIPHyF2Fj008jurhw19cArK/l68VPleim/jEyxm2U17jPrLHXZ6/ZimfLLY+md8WG1wyRekVPZvjTiXjDn82jt8ECOHJnWHR9DxB+7GNnT9K3oqaHzR82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAVGt1tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87393C4CED1;
	Fri,  6 Dec 2024 00:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733445193;
	bh=oS5NCBYgIe5Rt3oU0o0kyzFCy0yCQTCK5DGI/tTJOac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DAVGt1tqy5g/kY/kSEmeoQuC13gboKIXHfCS8AtvNoAh8FxYgVLdELM/RKd20TF5u
	 KK1Fil6J5RSE5ApAspvpyok8fkKIH/UCHpsVO74hBKnBj8SMKSDipBawgNe5+leOKe
	 QLg2RJXDGr/QjPnIGoSGro+kaZYSbfOEiyGUvibN2XhTZqGt/BeXtRS83UPD53hI3I
	 8sYDuC+yj85Argm6IeO5Qp1ZDlyVIFoth3HZ0OfCl0PJtpE2jTla8p7+C4q23knBX6
	 a4YGWceKHZ8dFTvYH1DfLR+icgCSd9MMJckBGBYf6WpCgbLhnkrRToz90CX203IUhH
	 JzGsPw8nr1Sgg==
Date: Thu, 5 Dec 2024 16:33:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH net-next v8 2/2] binder: report txn errors via generic
 netlink
Message-ID: <20241205163311.5eda36f6@kernel.org>
In-Reply-To: <CANBPYPgzGKfu-P8dH9tdgdNPAGz1TMcmQVbJF2XFhaX0W6ig-g@mail.gmail.com>
References: <20241113193239.2113577-1-dualli@chromium.org>
	<20241113193239.2113577-3-dualli@chromium.org>
	<20241204183550.6e9d703f@kernel.org>
	<CANBPYPgzGKfu-P8dH9tdgdNPAGz1TMcmQVbJF2XFhaX0W6ig-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 04:01:01 -0800 Li Li wrote:
> The system administration process always runs before any other user apps.

I don't wanna comment on that, since I don't know binder.
Perhaps you could add a comment to flag this to binder reviewers?
I want it to be clear that netlink provides no concurrency protection.

