Return-Path: <netdev+bounces-112303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC59382BD
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AEE1C20CA3
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2B39850;
	Sat, 20 Jul 2024 19:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDB716419
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721505189; cv=none; b=HZflALrUyrXGvMam+2LD8NGo60k2t4PSg7nXCp7uaLWQBdV6gHR74TR43VH/qo5/KxxtDnZL7JE9HxPIMT27T9E04FpVmY1E71EYV3huobkruiz3NthUwh3+awNVc9VAlqsg5IxtGcIR5sfxFvUtrun4AyE8hL2KkU39v6WtxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721505189; c=relaxed/simple;
	bh=nh+asBkIuvfQrS3n2d1ONrJ1w9JODaf3C14y8gv9CKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGznKQ0sn55DoAgJmGf+QKH58tIcB3OU0MY5yDT98eqnPeiznklvHlzQpufo8Cw7vnDJMTQbVjzD/+AaJYt/vc1AiZZwoJZ+ABvZAMklZzJn9fUSrdQTjuOX8fRQlyh7A9x+gcTqEl3e4gOskNMZfRVr242fgjEAte5km+DRjwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from dhcp-8377.meeting.ietf.org.chopps.org (dhcp-8377.meeting.ietf.org [31.133.131.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 7EB8B7D018;
	Sat, 20 Jul 2024 19:53:06 +0000 (UTC)
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: netdev@vger.kernel.org
Cc: chopps@chopps.org, chopps@labn.net, devel@linux-ipsec.org
Subject: xfrm/ipsec/iptfs and some new sysctls
Date: Sat, 20 Jul 2024 12:27:38 -0700
Message-ID: <m2bk2rx2lb.fsf@dhcp-8377.meeting.ietf.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


As part of the new IPsec IP-TFS code we are adding a few new xfrm sysctls. These sysctls are used for setting the system-wide defaults for new IP-TFS SAs. New SAs can still override these defaults on a per-SA basis.

The thinking behind adding these is that IP-TFS is still a new technology and we'd like to get deployment experience to find what the best default values will be.

Does anyone object to adding the new sysctls? (doc included below)

Thanks,
Chris.


xfrm_iptfs_max_qsize - UNSIGNED INTEGER
        The default IPTFS max output queue size in octets. The output queue is
        where received packets destined for output over an IPTFS tunnel are
        stored prior to being output in aggregated/fragmented form over the
        IPTFS tunnel.

        Default 1M.

xfrm_iptfs_drop_time - UNSIGNED INTEGER
        The default IPTFS drop time in microseconds. The drop time is the amount
        of time before a missing out-of-order IPTFS tunnel packet is considered
        lost. See also the reorder window.

        Default 1s (1000000).

xfrm_iptfs_init_delay - UNSIGNED INTEGER
        The default IPTFS initial output delay in microseconds. The initial
        output delay is the amount of time prior to servicing the output queue
        after queueing the first packet on said queue. This applies anytime
        the output queue was previously empty.

        Default 0.

xfrm_iptfs_reorder_window - UNSIGNED INTEGER
        The default IPTFS reorder window size. The reorder window size dictates
        the maximum number of IPTFS tunnel packets in a sequence that may arrive
        out of order.

        Default 3.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmacFaASHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAll/oP/2Az9cwTtrmdEpUHpFKlO0GaWcbrHuCT
37KXLTAgyGQ2OH4tP0pahac6RMPEEsvt5AhBNClbfPvvxRnwOgdW7JDrKm3fzQt2
YjBRiUVWHG4GBFwibesnaUPYifAuNlYHuJi2Un6cnFl1Z2B6dA7H1umzI2fYy7qy
+UDQx2iawk+JBJidyTv9Sk+B2ftofZT+rQssvehlwUj9xZs2dInfOctc7XX1IK57
6LC/PUpG306xK7w/HRzWiVtDFeQSitIf8g6Czq7wMwfAAcO7xdTPYXkKe7mZ32bN
6Z5zNJPsVEzf2PviPxefNOAs7D+obsBHsBce/7rG7rJJqveaccDA3WiarlEUvZi5
tLKXZSPd/aMQW+XHQHuBq4u0EVeprDn0x8Umyq1YHoK7LWyQx3tHg/GNRuXuMOkf
zLo40FZmL/e+1f8kA/zqHLLqAAej6htGWmguE8wKbVy6GgOdOK7LPc1qB2Oiw28t
SrEc7GZPyVvVNaH3wNy8/Kq+vlmus79epcu5DmklyN4MWpPXusWfs4DZglVHjRk5
nIawClcnWBSgY1IB3WKPIFlGKBM4iK2CC6cWvM1x96GXqqiHBD7h5FZDYcaXXhsR
JPoYrtka47XNGLJHHbQUEzTMFrjwHLtHI5CXA0fwZsSGkFimQ0wVw34wg0Ua/D6/
raPsfugusJjF
=QzzF
-----END PGP SIGNATURE-----
--=-=-=--

