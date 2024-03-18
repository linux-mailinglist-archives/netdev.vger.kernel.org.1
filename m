Return-Path: <netdev+bounces-80315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB287E51E
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749151F220F0
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D426AD8;
	Mon, 18 Mar 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDP/VMWd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C125779
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751440; cv=none; b=I6uxicJlE9aLgbFclxGEG+z2T4IYOTFPSrLT4Nn/hsNhR0Ar+C/TdrBlvdCoZQ0OI3SwrzIhGzYaXVslywapycBADcE8lSYlb/Nfy2DmIvB6ue6jvE7Di5jaZ2gV7/A9ur18bZR18odrTzgXMFhleemfeXA8uD0WMcwcfUlRH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751440; c=relaxed/simple;
	bh=3ZV/5uA86R4hstK4uahfTImlbM+Q4kTy84q4BM2Iv14=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=UTJeygXwsKlHzQTKqIpeAlOQV3Mc9TtZMg7o1Y77v90T3zUjrGP3uEQlLcSeV7rQI/DC7PV+ykHdxfzfok06GOkRqXrIcDigmTkBMvIY3xKI4o6UxQAX2UDRJW7rG5/mavWemihiJO5mEp8LVBu63cOw1kM3tH8XPk3E/UGgZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDP/VMWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54CC433C7;
	Mon, 18 Mar 2024 08:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710751440;
	bh=3ZV/5uA86R4hstK4uahfTImlbM+Q4kTy84q4BM2Iv14=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=vDP/VMWdEp3Z+TLm5VI1mG3ZJSp3z8ZrvL8p/a9BDf8zYJPM2fw2jp5UKN1Rk6bHv
	 w/yjv8chA9Q1XIBnMc9DCGCUnUA8G5D2I16ePvaL5X/1otN0x/Q6YHCOfJH7Hf/1D+
	 vMZASsJ9oniBEpeF0xx52p4Z5JXRpSbwsPGebMfaRybHG1YyGa6fjpiUHhPAUhi6dA
	 vqLZvWb77v9eMjJ/zpKOBV0FusMK7dpdKk8ENDaFiDVMJvj6jnzMArd+vMeFOZW2bH
	 b6qCdCeGmVwPkxUpveZ0eWx8wv9V/bLqeQBbdik+f+w4eud5rYy5JYbkqThvRWnMy6
	 7xn514rqer2fw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65f5be1e42018_6ef3e29485@willemb.c.googlers.com.notmuch>
References: <20240315151722.119628-1-atenart@kernel.org> <20240315151722.119628-5-atenart@kernel.org> <65f5be1e42018_6ef3e29485@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net 4/4] udp: prevent local UDP tunnel packets from being GROed
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 18 Mar 2024 09:43:57 +0100
Message-ID: <171075143709.25781.8757835262812630133@kwain>

Hello,

Quoting Willem de Bruijn (2024-03-16 16:43:26)
> Antoine Tenart wrote:
> > GRO has a fundamental issue with UDP tunnel packets as it can't detect
> > those in a foolproof way and GRO could happen before they reach the
> > tunnel endpoint. Previous commits have fixed issues when UDP tunnel
> > packets come from a remote host, but if those packets are issued locally
> > they could run into checksum issues.
> >=20
> > If the inner packet has a partial checksum the information will be lost
> > in the GRO logic, either in udp4/6_gro_complete or in
> > udp_gro_complete_segment and packets will have an invalid checksum when
> > leaving the host.
>=20
> Before the previous patch, the tunnel code would convert ip_summed to
> CHECKSUM_UNNECESSARY. After that patch CHECKSUM_PARTIAL is preserved.
> Are the tunneled packets still corrupted once forwarded to the egress
> path? In principle CHECKSUM partial with tunnel and GSO should work,
> whether built as such or arrived at through GRO.

Previous patch removed the partial -> unnecessary conversion for
fraglist only; but packets GROed by rx-udp-gro-forwarding can hit
udp_gro_complete_segment and the partial info would be overwritten
there in case of an UDP tunnel packet GROed at the UDP level with the
inner csum being partial.

Thanks!
Antoine

