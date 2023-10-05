Return-Path: <netdev+bounces-38197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000AE7B9BEF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 10:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 159BC1C20853
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B2DDAD;
	Thu,  5 Oct 2023 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EasewVdw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D75690
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 08:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090C0C116B4;
	Thu,  5 Oct 2023 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696495954;
	bh=kdOVueCUGc2zsRpYF5bysHxKXG55y67tcQidRcCIZ4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EasewVdwafoq1yx5+UNUcJalaL3xX5dSjjN+pyIqUFn5/aR2m2nSP3mS4on9JKg+p
	 G/jLyzOGa/cKdy//fnXTwvpp96dopSUsnkSx2WE4GLx0Bm1f/JAmZfpvUZTIZPVj8c
	 lm8nU3NWPMw3WioArHBHdUbVEe7FeZf0o1VB00JzAsvhpfzC22EHj1U+rFiqLG0HAz
	 GUkMU9x6PZkzDq9NaG444korw8CX4jNAahoJb6tBBt7sMiHxnHAxj7wmG10UurFtSo
	 u9QGCVeT5zvvssOZBONO3snD22mkZ8XicLO5YoX2qrprbxPBoOxpAPLEP4sVvN6AHz
	 eAw0TOVqn1T/Q==
Date: Thu, 5 Oct 2023 10:52:30 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	neilb@suse.de, chuck.lever@oracle.com, netdev@vger.kernel.org
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Message-ID: <ZR55TnN4Sr/O5z4a@lore-desk>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
 <ZQ2+1NhagxR5bZF+@lore-desk>
 <20231004100428.3ca993aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7N7cDQtYTEJaPqIG"
Content-Disposition: inline
In-Reply-To: <20231004100428.3ca993aa@kernel.org>


--7N7cDQtYTEJaPqIG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 22 Sep 2023 18:20:36 +0200 Lorenzo Bianconi wrote:
> > > matter at all. Do we have to send down a value at all? =20
> >=20
> > I am not sure if ynl supports a doit operation with a request with no p=
arameters.
> > @Chuck, Jakub: any input here?
>=20
> It should, if it doesn't LMK, I will fix..

ack, what I want to do is add a 'get' method w/o any parameter in the reque=
st and
with just one parameter in the reply (i.e. the number of running threads). =
E.g:

+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -62,6 +62,18 @@ attribute-sets:
         name: compound-ops
         type: u32
         multi-attr: true
+  -
+    name: control-plane
+    attributes:
+      -
+        name: threads
+        type: u32
=20
 operations:
   list:
@@ -72,3 +84,54 @@ operations:
       dump:
         pre: nfsd-nl-rpc-status-get-start
         post: nfsd-nl-rpc-status-get-done
+    -
+      name: threads-set
+      doc: set the number of running threads
+      attribute-set: control-plane
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - threads
+    -
+      name: threads-get
+      doc: get the number of running threads
+      attribute-set: control-plane
+      do:
+        reply:
+          attributes:
+            - threads

running ynl-regen.sh, I got the following error for the get method:

$ ./tools/net/ynl/ynl-regen.sh
        GEN kernel      fs/nfsd/netlink.h
Traceback (most recent call last):
  File "/home/lorenzo/workspace/nfsd-next/tools/net/ynl/ynl-gen-c.py", line=
 2609, in <module>
    main()
  File "/home/lorenzo/workspace/nfsd-next/tools/net/ynl/ynl-gen-c.py", line=
 2445, in main
    print_req_policy_fwd(cw, ri.struct['request'], ri=3Dri)
                             ~~~~~~~~~^^^^^^^^^^^
KeyError: 'request'

am I missing something?

Regards,
Lorenzo

--7N7cDQtYTEJaPqIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZR55TgAKCRA6cBh0uS2t
rN7DAQDYvw5l8F0Tv6kl9SuPPswPeHXr1Pynz59ksPeQTxeqaQD/Q6msrDMf8c0K
TY2kVQ03zUHHaVJ7j68Ld650M0i1nQA=
=QllE
-----END PGP SIGNATURE-----

--7N7cDQtYTEJaPqIG--

