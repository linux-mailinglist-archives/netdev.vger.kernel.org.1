Return-Path: <netdev+bounces-106973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C6E9184EF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248A41C21FA7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA801850B8;
	Wed, 26 Jun 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4TLyiUb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32841755A;
	Wed, 26 Jun 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413663; cv=none; b=lok7ZTFSVho+foPpVwcK6dWW9QiNEvm4m54CU9sGLgj3R+nZtXxy9OwBM6bBi/CMiaO98vIDTD8ieZz6quZIv0qOnvP1/83Niyt9Nc183N0/4ruK655Wr46z2LrrQx6pStufxfmYJSLUWFiMdilMrgpIx6tzT5iNxLR9r2Rom5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413663; c=relaxed/simple;
	bh=PU6wWxCZxNzkbndveZGAix6meiJPboaqpZHVRWhzdFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bur+VZj2YywlDiOQaiYB0iSBcyMXZ3TMcAg0iGvWyhSwFWApZPG2/1LWnIzpMk+CUXSDN9NxnY50cXOR8nF/rJam44uz3tJo6vXpJJ3As/9wvS2pVweEO7pySASfgGHKrRJZBPsWk6C1LeqVJ0UPs/x7MqfjOIsarKz6iSXGirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4TLyiUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0E2C116B1;
	Wed, 26 Jun 2024 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719413663;
	bh=PU6wWxCZxNzkbndveZGAix6meiJPboaqpZHVRWhzdFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j4TLyiUbX3qFaIAJf2nNVAsTMJ0D0G0X88HycHl7yjGETz7bTHHS2YdkdVPnFijHK
	 H2ihPqhvdxN27U5gZfohoreYKH4lAf9sSl0ldXc45ChzKLmD88prjhPL7qua7jDNTp
	 qoYXve9rxV5T2kwoBPPW0lNR0ap1ZwO2mOR2MVoUlPTaz5Xp/LKuI6NeSKPsJE7YnX
	 yMGVa+qkTL9zC8u54LJ/S19TXw6O4TKgT9hjnnUINSgDntxHYseqUKabWhblEX1jof
	 cA6KheuVlyr08Pa3i3ZQuVSOl1k6JHfIKhCEoyAS0w3s5llgRDwqKtImGehqMSQhtz
	 WHNKPBavM8nGQ==
Date: Wed, 26 Jun 2024 07:54:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
Message-ID: <20240626075421.1430e8d4@kernel.org>
In-Reply-To: <20240625114432.1398320-2-aleksander.lobakin@intel.com>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
	<20240625114432.1398320-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 13:44:28 +0200 Alexander Lobakin wrote:
> -		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %llx\n",
> +		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %x\n",

compiler says %lx

net/8021q/vlanproc.c: In function =E2=80=98vlandev_seq_show=E2=80=99:
net/8021q/vlanproc.c:241:69: warning: format =E2=80=98%x=E2=80=99 expects a=
rgument of type =E2=80=98unsigned int=E2=80=99, but argument 6 has type =E2=
=80=98long unsigned int=E2=80=99 [-Wformat=3D]
  241 |                    "%s  VID: %d  REORDER_HDR: %i  dev->priv_flags: =
%x\n",
      |                                                                    =
~^
      |                                                                    =
 |
      |                                                                    =
 unsigned int
      |                                                                    =
%lx
  242 |                    vlandev->name, vlan->vlan_id,
  243 |                    (int)(vlan->flags & 1), vlandev->priv_flags);
      |                                            ~~~~~~~~~~~~~~~~~~~     =
 =20
      |                                                   |
      |                                                   long unsigned int
--=20
pw-bot: cr

