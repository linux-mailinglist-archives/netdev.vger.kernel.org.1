Return-Path: <netdev+bounces-209929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6FB1156E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343B01CE02FF
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457E26281;
	Fri, 25 Jul 2025 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="ES/k3jL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMalNQ2j"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC2BA3D
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404496; cv=none; b=coEgn9taBBPkIL61c4tfXtOfnkdYhufn9QjdwjeqGP6olVpoYQRL5uQ2/1HuvjIHs97OgrB2hjlgTVgIXF+msLeLVAsFmwcxve8SX++Z7TI6uSCXjdJ4kEB4/VU7MNyaTBqo5aM2eDUkouFr+7wjyNwft7BgQgwgT1a/5dXilf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404496; c=relaxed/simple;
	bh=A6gm+SRhrD28/XGf6jOFHNantSkVBwakp7dSSf7w/Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hA2yj1vpjPPTp5/JuOAmCmYpnyQtiw3Z7ACQ2U59YjqOPE+fVUChneoIl+xUyDpHcmDQSIHRbJoURFXwnLdMCfZ2v9DDvCvQxSyDpJ2lTcurpXiFY1I7c8kQrkXv1bRfKB6itIUTDf3veo+yM9wRdNzRNY3RBrzxCk5vKEskOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=ES/k3jL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMalNQ2j; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9BBBCEC03DB;
	Thu, 24 Jul 2025 20:48:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 24 Jul 2025 20:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1753404493; x=1753490893; bh=AInzQ+tQUBykenqt1M742
	ky9iW5yejB/DlYiS4wsJ0o=; b=ES/k3jL9NETivoYqVHTIwOR1FdH2Yl/2NlTLy
	Y3Q8hzXVe1V5qteSMG+PnXs7fGIA7BDddIubzzdmjb+M0oMGPe8sgCPgJnarojdI
	g0LR4D3X1ZviSKFL1CHfQWc4HF9SsQzdWnuRgiFSXvvsDwqBQzQ+sxmBl4nffw4x
	45XAMPo2oSVW3pU1AB3WdXoHklm5Lk+aPN6MQ6koYzYVXuiex8kPrLTHzRvPvSzq
	Hh9Kjaam/sijdADP5txUY9MU2vFbDWy2xA16no+VcpE7MdSoxHIV+4APfTW6rfPm
	5v0BkKQRL+tcyw1Z5UnXIcfNw5UxNViGfB+xIWrrY/8lSJJ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753404493; x=
	1753490893; bh=AInzQ+tQUBykenqt1M742ky9iW5yejB/DlYiS4wsJ0o=; b=U
	MalNQ2jGGsB5PCj3ZWcxvAhHQ+L9YLBNuqHdTYT/mmI3397f+oiJHaPCxC12WZpb
	uuUqqOA/ZS95zcqJd9jCZnYZn5m7567ZN4C+6pLuGjRV3yWWj5inC6TQRBule2Zl
	p5/Q4HpCcFCcTFcwsBhqaYbAWwbIhQ95xLhgiFFDeux6r233wOtDUoeedpTIFjwS
	KCIe1IRwOFx1iyIjLeE/f9Z+2v3o6GIu+SmL0UvqhKbb3+5IcJmK7fcJkQCR/+6T
	7t0evIvNCSg4sbqKtvlXegdEJbIQVaiH4ac8H3cMUpmfWGPkCVEGo6zzEDffhuR/
	IP1NMMoMEpw44mpfI8p9A==
X-ME-Sender: <xms:TdSCaKrg1J_WkEbZSSx_ij7sSkZ5Av0m-0rBp5u2acMoP2s6HxLneQ>
    <xme:TdSCaL5ssgwo2pEA0H8rA3D4g8OspQotCG3MgzJlFzgxPPPKzgYBwAj3xZMoByeCI
    monJlIM-8v5NoTwdKo>
X-ME-Received: <xmr:TdSCaIqEnaEpm_hE22D3exgfD1By9sSnfIayvBDI579c0JLQcaXz06EQQnNzfX_gYKw3Lsz9gmpKwfhVZ7VNMm0GBqo2q9wSudQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefoihgthhgvlhcunfhi
    nhguuceomhhitghhvghlsehmihgthhgvlhdqshhlmhdrnhgrmhgvqeenucggtffrrghtth
    gvrhhnpedvleejhfeggfekvdevfedtgeeihfduvefgvdejheethfegfeeltdetjefgveev
    veenucffohhmrghinhepkhgvhihogihiuggvrdhorhhgpdhfvgguohhrrghprhhojhgvtg
    htrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhhitghhvghlsehmihgthhgvlhdqshhlmhdrnhgrmhgvpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmkhhusggvtggvkhesshhushgv
    rdgtiidprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TdSCaFjmvpp1YPpnEH-tvfXvVuTsqP7RyI740Eyld36l0Ep4j4KBcw>
    <xmx:TdSCaKKk7BlAXccpj9oGU6uMIyqzJecfL5xQXb58gs4FRedw-Irn-A>
    <xmx:TdSCaNCu1lQ1v7t2KfYkspPvVrR5Vc9fl8Xw4wChSY5xw4dWfoNp2A>
    <xmx:TdSCaCgPZuvp4h71OQxiHare70A9otTu4iqWS5VEXpi_6LRLXT34dg>
    <xmx:TdSCaFg9e56WzVYIRIxeBslOqnmL-78MLgyGjSbqjuIrpIPPMv8mOaxA>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 20:48:12 -0400 (EDT)
Date: Thu, 24 Jul 2025 19:48:11 -0500
From: Michel Lind <michel@michel-slm.name>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH ethtool] netlink: fix print_string when the value is NULL
Message-ID: <aILUS-BlVm5tubAF@maurice.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gpdfvliWLdsgZRKF"
Content-Disposition: inline


--gpdfvliWLdsgZRKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The previous fix in commit b70c92866102 ("netlink: fix missing headers
in text output") handles the case when value is NULL by still using
`fprintf` but passing no value.

This fails if `-Werror=3Dformat-security` is passed to gcc, as is the
default in distros like Fedora.

```
json_print.c: In function 'print_string':
json_print.c:147:25: error: format not a string literal and no format argum=
ents [-Werror=3Dformat-security]
  147 |                         fprintf(stdout, fmt);
      |
```

Use `fprintf(stdout, "%s", fmt)` instead, using the format string as the
value, since in this case we know it is just a string without format
chracters.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Michel Lind <michel@michel-slm.name>
---
 json_print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/json_print.c b/json_print.c
index e07c651..75e6cd9 100644
--- a/json_print.c
+++ b/json_print.c
@@ -144,7 +144,7 @@ void print_string(enum output_type type,
 		if (value)
 			fprintf(stdout, fmt, value);
 		else
-			fprintf(stdout, fmt);
+			fprintf(stdout, "%s", fmt);
 	}
 }
=20
--=20
2.50.1


--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2
     README:     https://fedoraproject.org/wiki/User:Salimma#README

--gpdfvliWLdsgZRKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCaILUSwAKCRCLIp0vfMwE
8i0HAP95LQD3FzwlSv3QlnSSAA6xv34+TibFTL92gXTLW14uZQD3V6p19UG6oAmU
9Nug5GAE+0vESWtAMdZIk98yTC4IAw==
=EPvx
-----END PGP SIGNATURE-----

--gpdfvliWLdsgZRKF--

