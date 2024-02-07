Return-Path: <netdev+bounces-69944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F284D1E1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA4B217A9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528F83CD9;
	Wed,  7 Feb 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="wJ67BNaj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADF83CC1
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332406; cv=none; b=VfsP4ns2OHA5wae5r/R88U06skSZNQ9aczp/lajoRZ1JNezY5SIdyp+Msx0BNIsufLJ9dpUEtSZaFI/Eu9KyuRAeBy8L1qaN4PYvtaTJbKkchhQGXUkWEXLFvghcdneb0420FU9MMVzY48M32r5ibGYqmTHU/bQGMHXWB9luGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332406; c=relaxed/simple;
	bh=QsH0mB7YxQSJT5AncPR9MEvvxe9p9xvNLNPij3c0CJk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XhBVOt3OhP5ZJKkJr7GwNoVQubh4a7aA9wCuNYygWTA2QbWpZLRAcp0TYUy70oWQuZtKh7RuRrLiYctngaFKAxzaKIdRuXTejLbECb1s9G59qbSehWBnL1YPfkDVUgvOmCg9rmmQxRmWUYQizXZgMctWo9nvXPExmWfc/crBAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=wJ67BNaj; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c02be905beso344082e0c.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707332403; x=1707937203; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YEQJwcrSI8/lOMP4p0HJ6TcpEwZhX5cObMYshEO4JM4=;
        b=wJ67BNajTPyQEGjCapDXlkOmgkd6stZvWB64/pB+lQXZ5+4IL3V+HrpPD1OyzQ/B85
         h6s5XR1ZMcvPc7wkzOEl2M1zFXZ0OzHYZ5SktXrK8V5Imm6jnXjKvrPGZTvsgDcokVbN
         3mPw1XOcAEKHFQSc6SynhX4oar+po1mmhL6hER4RacXssru4xJ1IAjNSVac3dn7wmAF5
         HBc3HfJFbo8ehE3wNQRBGQ8S+CSKnZoyLigwwBNEfwXgHn2ks6Zhf6gWRHWmYQNUWReF
         jLVSYZ5jFhSnTqEg1NkTEYr/xR0G8xg2RXd2htncNxlw1BeGrPJZmgq8ThK/NuT9SqUk
         Aiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707332403; x=1707937203;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEQJwcrSI8/lOMP4p0HJ6TcpEwZhX5cObMYshEO4JM4=;
        b=rFMMClYdgTcprZHMk5MmDhxXbA9qvd28c5Xc5Qq6YitvFMbeXWXGAiOIkA5QyfHGGa
         C1y9P2UQsPKAVJIE+qovrsugEFZw9QcpohhVuBZrnFf10gYEtwfzsrOfM+UO4BlUZp14
         UeSg3w+RR3xuexUXENqx5eI4UqxLbKuah8ceH2ZXalgxk3A2rsn7h1adsE1GHc2cnVYU
         2mi7J15mXWp9scxfsprsNeRDUVxuM+IUiucxzRLKerRormbgOg6wS+s6D3WzFH5rZtxQ
         oBR2u8zPYxWsqjPgkZFnbq0II/b2iOrOrs/s70C5JIxNXLOOMJROfvx35olxE2WHTvBq
         tOrg==
X-Gm-Message-State: AOJu0Yx1cAft9nE9i2hl8ReRI2LVNi8uCEwZX8ND7GufOuLl4LK+/Rre
	rIrvys87o6Gr7Y6Q3uYl2/0N9YkyOx9R6ezorG/icsekZoNOY0U01zoXR0AuBKNBjrPilUibZS7
	f3KhUePqcvhyvG6XnabGrKwvJp+g6kx73JthZMVU92D7Cd4QIi5/2
X-Google-Smtp-Source: AGHT+IGXgP+Sh830jwKWVUqa4hp7/py4mJhN37OOPF8/yX9q+2Lz1tYuM4NXdTHGH8Sl9ZMf3faWgAaN/izJggohBKE=
X-Received: by 2002:a05:6122:991:b0:4c0:2a19:7182 with SMTP id
 g17-20020a056122099100b004c02a197182mr3978870vkd.8.1707332403285; Wed, 07 Feb
 2024 11:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 7 Feb 2024 10:59:52 -0800
Message-ID: <CALCETrVJqj1JJmHJhMoZ3Fuj685Unf=DYsiEY1uEfnJq3H+Tzg@mail.gmail.com>
Subject: Raw sockets cause unnecessary, expensive skb clones
To: Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I was trying out dropwatch on a system that is incidentally running
tailscaled, and I noticed an utterly absurd number of drops.  After
digging around the Linux code and the tailscaled code, I figured out
the issue.  Tailscaled opens a raw IP socket bound to the UDP protocol
with a filter that should reject essentially all non-tailscale traffic
(and it does this for vaguely silly firewall-bypassing reasons that
may or may not make sense, but that's sort of secondary).

Linux passes incoming IPv4 packets to raw_v4_input, which tries to
ignore things, but not very hard, via raw_v4_match().  raw_v4_match()
considers protocol, source and dest addresses, and interfaces, which
means it matches literally every incoming UDP packet when tailscaled
is running.  Okay, fine, the socket filter will pare this down
cheaply, except for:

struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);

This happens before raw_rcv -> raw_rcv_skb ->
sock_queue_rcv_skb_reason -> sk_filter.

On a quick inspection (and I'm not nearly familiar enough with the
code in question to believe this right away), the only thing that
happens in between skb_clone and sk_filter that actually requires
cloning is ipv4_pktinfo_prepare().

Does sk_filter require ipv4_pktinfo_prepare() first?  If not, perhaps
sock_queue_rcv_skb_reason could have a new option that would tell it
to clone the skb itsefl and ipv4_pktinfo_prepare() could be pushed
down.  Or raw_rcv_skb could do the sk_filter itself and arrange to
skip the subsequent sk_filter call?

FWIW, packet_filter() explicitly tries to avoid this problem -- it
even has a nice comment:

 * This function makes lazy skb cloning in hope that most of packets
 * are discarded by BPF.



-- 
Andy Lutomirski
AMA Capital Management, LLC

