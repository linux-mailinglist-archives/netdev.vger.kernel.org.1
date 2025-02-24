Return-Path: <netdev+bounces-169119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA0A429CE
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FBE3B3C33
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ADC263F5B;
	Mon, 24 Feb 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8QZyMU9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A437263F3A
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418136; cv=none; b=bXwTm0vNWeJEfPlKgHmIwZPRIZD2UICDj8DO3iYshMj1BzycGfZ8MXRT7qzt2q17UCEkHHk0Jxm5kzurt2Ovw2lnsPQU3YtIkPtAfrQrnXMuz8SWMrIzxC8SjC8dpn/zevnvXZ04l+sFU3CJwhZci7iaRREKY5iAIySRfRfAokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418136; c=relaxed/simple;
	bh=v9k0+RFzAb8cDYWgGRn036nQFJQ8CM6wP77iD1A78uk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EM9Ssd/3GbYEm2DmSFeEhJXPmvUZjGEc0GzbUdW7+aljhb1Exi1SxpsFYwi/e0Ls35ivGQqnHGAM8h2tBqw1qgWQgelr33vDbAly19jMK6h8062cc6x1ZshBJ3g8aH99UZcuOhGP1zy0tVeO2yfgu92SjkC0Wzi4qciGGTllsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8QZyMU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740418133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9k0+RFzAb8cDYWgGRn036nQFJQ8CM6wP77iD1A78uk=;
	b=e8QZyMU9OcnXgkKoFuBAqeoMCkrjee7YxYk1ysYAUOTgz16xJuUei1FmZ0/nejJDU7T8iv
	ekRfBS8W+mwUXhOrbjYH1hRvxPk95flgYTyqRAb18v9MIZwjadJyP2hyYINsQVsIlPTaCi
	PCbxFVGT6VOr2XvdB9yZKUSRWoNKz1Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-utQLVqiqMJuf3a1hZtIQgA-1; Mon,
 24 Feb 2025 12:28:50 -0500
X-MC-Unique: utQLVqiqMJuf3a1hZtIQgA-1
X-Mimecast-MFC-AGG-ID: utQLVqiqMJuf3a1hZtIQgA_1740418129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B001E1800373;
	Mon, 24 Feb 2025 17:28:48 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.42.28.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7360D1800945;
	Mon, 24 Feb 2025 17:28:46 +0000 (UTC)
Date: Mon, 24 Feb 2025 18:28:43 +0100 (CET)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
    Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
In-Reply-To: <20250221144408.784cc642@kernel.org>
Message-ID: <2a7ed528-ed5d-d995-f7fe-12e3319aba27@redhat.com>
References: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com> <20250220165401.6d9bfc8c@kernel.org> <c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com> <20250221144408.784cc642@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, 21 Feb 2025, Jakub Kicinski wrote:

> Hm. Wouldn't we ideally specify the flow length in bytes? Instead of
> giving all machines 1 sec, ask to transfer ${TDB number of bytes} and
> on fast machines it will complete in 1 sec, on slower machines take
> longer but have a good chance of still growing the windows?
>

Thank you! I will try this in a 'fast' system to tune the number of
packages equivalent to a second and with that again in the slow system
under test. Maybe with this there is no need to change anything but the
-l parameter to netperf.


