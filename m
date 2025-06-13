Return-Path: <netdev+bounces-197473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E20AD8BBD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41571891CEB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31F275AE2;
	Fri, 13 Jun 2025 12:09:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A832D8DD9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816591; cv=none; b=g/iWjMtFd44oN302TFmvjAv0Jvtt97Vx/qmrKbFaG2yo+Tn2aWJzPG6xk8KoryU1dy44U4J29cmTDKYIL/nDC2Y3nCbaSp3AxzoC2SrbA4Q09usm2g1qB0bPVcX6VqfW3zo0RydYqJzjpCVbCY6JFb/v4DlPpn1R8tdnl6MZ07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816591; c=relaxed/simple;
	bh=pk0lQdv43C/rZv579FMX5Hagj+NuYzOwntCyzfrP9rM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JKET1eIlKRV3waDv4L7bgG5neaXU8xA5v/JEXNbTxDJkXHPa+Kms+tzOZtQi/CKWQC9GDcVcZDmwbrPD2P4ljD69wQ3YvL3gQKFe0eH5aAymZg/eCoxYpjpmAgXjj8t8x3p7Zn0Eu2gFxKV/k5AZeMIUv9LsROpHD2Z5RELMquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (2a02-8428-1b1d-4d01-96a9-491d-7b48-ba31.rev.sfr.net [IPv6:2a02:8428:1b1d:4d01:96a9:491d:7b48:ba31])
	by joooj.vinc17.net (Postfix) with ESMTPSA id 2CDB236F;
	Fri, 13 Jun 2025 14:07:12 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id 01772CA0114; Fri, 13 Jun 2025 14:07:11 +0200 (CEST)
Date: Fri, 13 Jun 2025 14:07:11 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: netdev@vger.kernel.org
Subject: [BUG] ip-route(8) man page: incorrect "ip route delete" documentation
Message-ID: <20250613120711.GA237002@qaa.vinc17.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.13+86 (bb2064ae) vl-169878 (2025-02-08)

Hi,

The documentation of "ip route delete" in the ip-route(8) man page is
incorrect. The man page says:

  ip route delete
    delete route
    ip  route  del  has the same arguments as ip route add, but their
    semantics are a bit different.

    Key values (to, tos, preference and table) select  the  route  to
    delete. If optional attributes are present, ip verifies that they
    coincide with the attributes of the route to delete.  If no route
    with the given key and attributes was found, ip route del fails.

But the behavior is unclear when several routes match the argument.
Above, the singular is used, so I assume that a single route will
be deleted (this is what I can observe). However, in such a case,
it should say "a route", not "the route", because the route is not
completely identified. Or better, say which route will be deleted
(it seems to be the first one in the list).

I'm also wondering whether the current behavior is actually the
expected one.

Note that the vpnc-script script of vpnc-scripts for VPNC and
OpenConnect assumes that "ip route del ..." will delete all the
matching routes:

  https://gitlab.com/openconnect/vpnc-scripts/-/issues/65

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)

