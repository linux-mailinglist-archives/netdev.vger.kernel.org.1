Return-Path: <netdev+bounces-116825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82E94BD51
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC362B22FD2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11118C346;
	Thu,  8 Aug 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiTdOZLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663A18C33A
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119877; cv=none; b=glTsHQjmEsN4YB/5h/zTSGyRVjcZUpQhTcZ7fbL0w4/Ig3jtIK4ejwW9dKFP8bv+C3HpjdJXNwryLezfl48SYR6+qCtggB8UyFNCLj053muUmbJakfRF/C/oVUM9rv1JBp+HxFclX5X4laM/6wrQmonPADaSNew7TQhLpoqjztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119877; c=relaxed/simple;
	bh=xmu+iOqr/GKosgcrVkIiCMZHVd1rT2OA8gpI5CdgpbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHxXpkfb6VsZdoPBVnhJtuct4+qxioCLEKqImvpGryQ0NZfm66Z7nbaNNFS5dthM95tstxW7rOQW/CbveE8WcZffO9DHSN0sPAidaKzGT0AhRDqxDdULu6eYQCeTLF0MjFuoCcyY8BJ2z2J/ulBaxC3sdDGQJqkSOLFgpX+UjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiTdOZLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B220C32782;
	Thu,  8 Aug 2024 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723119876;
	bh=xmu+iOqr/GKosgcrVkIiCMZHVd1rT2OA8gpI5CdgpbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IiTdOZLAWDHM8JsSg07sX5MhC3v9b16j9iDqcUGPtuaClyup/udzlpOdNh1at5Q3w
	 9n4M3KBpK9d5jftMad38wvX1WacezQhYFW4Gk+893s8HHi6+75P7IisA1UmOKLRx4D
	 gO8Y5ZIRfb697UjfE4HiVJuUWS2QDdWLdhSJ6jqpA4kx0L1Vn36E7Q2G45Pgb0TXiu
	 bF1jKmmDbkwMqa6GIcJDvVIHS+QOXYaaKUO4bE+rGLg6015mQ3A5Rbb1OYgo0fyZ0a
	 ItyUgOowTVMZIcR/Qz4V0s26jt1VLouXiX5ti9dChUULGqLksRk4Zx80a8DdQO8sb3
	 xmijAs491ciGA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9D43014AD6C4; Thu, 08 Aug 2024 14:24:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: djduanjiong@gmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
In-Reply-To: <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
References: <20240808070428.13643-1-djduanjiong@gmail.com>
 <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
 <87mslnpb5r.fsf@toke.dk> <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Aug 2024 14:24:33 +0200
Message-ID: <87h6bvp5ha.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

djduanjiong@gmail.com writes:

> This is similar to a virtual machine that receives packets larger than
> its own mtu, regardless of the mtu configured in the guest.=C2=A0=C2=A0Or=
, to
> put it another way, what are the negative effects of this change?

Well, it's changing long-standing behaviour (the MTU check has been
there throughout the history of veth). Changing it will mean that
applications that set the MTU and rely on the fact that they will never
receive packets higher than the MTU, will potentially break in
interesting ways.

You still haven't answered what's keeping you from setting the MTU
correctly on the veth devices you're using?

-Toke

