Return-Path: <netdev+bounces-80343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEE487E6A1
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA2D28188F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7232D044;
	Mon, 18 Mar 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdc99sRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C436C2D043;
	Mon, 18 Mar 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756224; cv=none; b=f2zq2vh28oWZk8YpqdZDho2CxHkCJ4ly6WNszcBdrhVZ8OIwyq//gVQaqcbwBdh4C8xkDrYQdphgtIr2QAPFsVP1XwYDSzsdpBjHp1bwO8MQ+OiIzncUZhGc07G5c13T+3KAcytB8EKQmAI4+bWc+6T89x+0JeKlYjQhirqc0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756224; c=relaxed/simple;
	bh=axnkQRaT2XDnF0eUK2wOc/SGNanPfba34MDBauyaiRo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=XYO0UfDRFDH9LctZHPJMBNvWdZWbMxF5fpsh9fSJ3Uj2VlWp/hLbHni5vFGhqMXzva0+jg+tzZ95fbATLFhtibSaXrZUotlE8F0nVmRBPVCs1oczHYNDm70gCjDcYmfmSRF4M0lZvxTBWr7XYnOXCysVSGi5tYDo6vg0botXHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdc99sRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AF2C433F1;
	Mon, 18 Mar 2024 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710756224;
	bh=axnkQRaT2XDnF0eUK2wOc/SGNanPfba34MDBauyaiRo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kdc99sRq/l6ZiHxMcc+itNsArOMWOreqOj0nxpRmpgJPzaMqowG4Vr6jTu0PYYM+V
	 T38F/h469UT8M+k3ren8XK0IU6dGtZatOpQsjMBItmBiUFMN+h1DDCz5EnfLC/vBPF
	 tbRWzbvbDHSMKPdIGyZL01yzcgqy/3z4vaqHPJY5Aan8V50Z659X1um+84DCbGU8du
	 QoqoLxQnfHBnrxJZk5fWpzFHw9Rqm7GfE/Oeqvkx/gd7DwBtOEFZ06pnjRTQ8BSWXB
	 eyvjuqiQwj3zlwy/foZTMmq0OqSe31xwbjEN8tgQcvnBRyAz7QHIFjLIIIDgSfw0oP
	 SFHDmkZ2j3OkA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202403160519.XghWVi81-lkp@intel.com>
References: <20240315151722.119628-2-atenart@kernel.org> <202403160519.XghWVi81-lkp@intel.com>
Subject: Re: [PATCH net 1/4] udp: do not accept non-tunnel GSO skbs landing in a tunnel
From: Antoine Tenart <atenart@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, steffen.klassert@secunet.com, netdev@vger.kernel.org
To: davem@davemloft.net, edumazet@google.com, kernel test robot <lkp@intel.com>, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 18 Mar 2024 11:03:40 +0100
Message-ID: <171075622074.25781.8502242285616689318@kwain>

Quoting kernel test robot (2024-03-15 22:21:50)
> Hi Antoine,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on net/main]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Antoine-Tenart/udp=
-do-not-accept-non-tunnel-GSO-skbs-landing-in-a-tunnel/20240315-232048
> base:   net/main
> patch link:    https://lore.kernel.org/r/20240315151722.119628-2-atenart%=
40kernel.org
> patch subject: [PATCH net 1/4] udp: do not accept non-tunnel GSO skbs lan=
ding in a tunnel
> config: arc-defconfig (https://download.01.org/0day-ci/archive/20240316/2=
02403160519.XghWVi81-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240316/202403160519.XghWVi81-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403160519.XghWVi81-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    arc-elf-ld: net/ipv4/udp.o: in function `udp_queue_rcv_skb':
> >> udp.c:(.text+0x3aca): undefined reference to `udpv6_encap_needed_key'
> >> arc-elf-ld: udp.c:(.text+0x3aca): undefined reference to `udpv6_encap_=
needed_key'

Issue is with CONFIG_IPV6=3Dn. The following should fix it,

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 51558d6527f0..05231fff8703 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -151,7 +151,22 @@ static inline void udp_cmsg_recv(struct msghdr *msg, s=
truct sock *sk,
 }
=20
 DECLARE_STATIC_KEY_FALSE(udp_encap_needed_key);
+#if IS_ENABLED(CONFIG_IPV6)
 DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+#endif
+
+static inline bool udp_encap_needed(void)
+{
+       if (static_branch_unlikely(&udp_encap_needed_key))
+               return true;
+
+#if IS_ENABLED(CONFIG_IPV6)
+       if (static_branch_unlikely(&udpv6_encap_needed_key))
+               return true;
+#endif
+
+       return false;
+}
=20
 static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 {
@@ -170,8 +185,7 @@ static inline bool udp_unexpected_gso(struct sock *sk, =
struct sk_buff *skb)
         * land in a tunnel as the socket check in udp_gro_receive cannot be
         * foolproof.
         */
-       if ((static_branch_unlikely(&udp_encap_needed_key) ||
-            static_branch_unlikely(&udpv6_encap_needed_key)) &&
+       if (udp_encap_needed() &&
            READ_ONCE(udp_sk(sk)->encap_rcv) &&
            !(skb_shinfo(skb)->gso_type &
              (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))

