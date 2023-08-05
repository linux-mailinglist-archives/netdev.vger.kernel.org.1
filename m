Return-Path: <netdev+bounces-24619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973F770DFF
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43411282692
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 06:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6601FAA;
	Sat,  5 Aug 2023 06:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79417C6
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 06:05:20 +0000 (UTC)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEA44ED0;
	Fri,  4 Aug 2023 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1691215516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yFtMnGLfEgodoGei2h8UZe336PyKSdPdvngnYXixpuk=;
	b=mnIpEaYqalGvm/XZ2MCRMjBcckZXRSyH5eNPNCEyomrA1LMmwPHuE64jRdARiRpPRCrHoB
	viphSUE6F/W7jKtbWFdqFJcUVEx5YiTj3O/Lh1xzOxncrA0o1KqEJEjsfaHhEK/4fHO8eZ
	XQbmBdxQaDkwHOEkin7OctVmp3XOwhk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 Remi Pommarel <repk@triplefau.lt>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
Subject:
 Re: [PATCH net] batman-adv: Fix TT global entry leak when client roamed back
Date: Sat, 05 Aug 2023 08:05:13 +0200
Message-ID: <2693362.mvXUDI8C0e@sven-l14>
In-Reply-To: <20230804093936.22257-1-repk@triplefau.lt>
References: <20230804093936.22257-1-repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12259810.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--nextPart12259810.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Aug 2023 08:05:13 +0200
Message-ID: <2693362.mvXUDI8C0e@sven-l14>
In-Reply-To: <20230804093936.22257-1-repk@triplefau.lt>
References: <20230804093936.22257-1-repk@triplefau.lt>
MIME-Version: 1.0

On Fri, 04 Aug 2023 11:39:36 +0200, Remi Pommarel wrote:
> When a client roamed back to a node before it got time to destroy the
> pending local entry (i.e. within the same originator interval) the old
> global one is directly removed from hash table and left as such.
> 
> But because this entry had an extra reference taken at lookup (i.e using
> batadv_tt_global_hash_find) there is no way its memory will be reclaimed
> at any time causing the following memory leak:
> 
> [...]

Applied, thanks!

[1/1] batman-adv: Fix TT global entry leak when client roamed back
      commit: d25ddb7e788d34cf27ff1738d11a87cb4b67d446

Kind regards,
	Sven
--nextPart12259810.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTN5pkACgkQXYcKB8Em
e0ap+A//aSI43I++QPAWQlTYcHVDZcDtCcVIk9qdSEvQtO62jJZYnBYyLZdvkcvY
/cQTjjSZY08wCzU3c9TEHPPnrZruRD+pDNn3m64izZhQ2BmAuHwIztociQytinan
I3oDTBL7wZYZu+66t/5NtRyD4vVE0Vr+1s0U1TR2DYkGALKsD9VGJOGKGLAJSF2i
PgDVjjDgqkEtdjvTnpC3a4phFumVfJLgNJBuuQ7FYEb+VQf37Wect8du4dMy+GNw
ifpZ+bqXWFKt0WP5M8r8T4M+NIpm3cS6a0ij3q4IVNI6xWzpmWjIiP2UG6lzpHna
BXOfPm2F7ArycTyyijg30hnTv3oV43Xpyy/vqMA7jRQRmnpeh9l96Rsew/MOouPQ
KUco8AazBnqOmX5fqpu1+uZFC+7h/ADVaUF6sbgfSQtyxPp0ggBAIAAAaHFfvGP+
1qLhIHCGPjdQVqRNpSHR85x5V5NYdlKwa91f/LE2oKz4Yt207/LNTeUfmYxeykz5
FsBwZPf77gdBCn0V533zqgreZ6aldqXp6+SWcbrKPChoV0h9AhfCsRQZGs+q4L6Q
Iwrh/iP+RQzWWLS/l6Xj9P6GSks3326kcWFPQwssdtXTZXPWAAhQ+m8lzIXbcaJ1
UGHrl6QLoNNr4/pnqCuTQmECHnSlMj//uB+KE1HaLp3JQZtV6z0=
=dwZT
-----END PGP SIGNATURE-----

--nextPart12259810.O9o76ZdvQC--




