Return-Path: <netdev+bounces-178241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E5A75D6E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 02:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F7B18895D1
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EE510E3;
	Mon, 31 Mar 2025 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U+Cdmzwz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="icQ5/v34";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U+Cdmzwz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="icQ5/v34"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BC1EA84
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743379745; cv=none; b=Ydx/EtXovEbApNGPuPd6Ze5coXeohGOeTkBhPgQn7mqLpu5yAv9p1QLexSaGzFc9jcGcUnX4qdsrafqAykn5pSg7t751az0yTd+GGQpipFHNsfMFzL/DfaOpAb+hgTqc36eoZ+f8dd7/918jPIjFkND4L2EOa1WGvAzAlSv4/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743379745; c=relaxed/simple;
	bh=+TiEsBKI6OODzQ6gSVygpWUqpNuIuC1oY1Fi+GW6rXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7F2ogkucul0iUL+ThkMohPGSxsEDfhcPuY7jPyL1gxGYMAv5U2mJ+vNdPKu9ODAbSgS53N2l40xBVgjhjd8B3OOAk/0t8kLSLyo8QHlytpcuyY7CxJ0rsYohbQG4aFAHsuLAA+vC5BcBdPHu8/C6K/+m9GR+TdxFdOEgWYYfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U+Cdmzwz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=icQ5/v34; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U+Cdmzwz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=icQ5/v34; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 866F52119E;
	Mon, 31 Mar 2025 00:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743379741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmoKIZLj2K0suh+6aN0oGatIG4BolsWfodLmPfQxRkk=;
	b=U+CdmzwzPapSw2A0uWh6tnT3Xngqx+H99WmCt1GaERbQBzzMpFXtWpYahdKqPpHeWIHNpB
	vOucfI5ien3mtyLXfHKR9WFRVewTrBJEEQQiXJs9pYaFuQ0/szurDamRuTa6Q7atWuawVa
	2vqJojNgzPjFkkhCskZ6uJCXY3j0Gks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743379741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmoKIZLj2K0suh+6aN0oGatIG4BolsWfodLmPfQxRkk=;
	b=icQ5/v34Uzw+QHuzJHfejRrRX9tqKewI8FagYkWB+xN//nKkUo19GSMUWekcclUT1bNIVU
	ojtfLjliw1Ar2UCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743379741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmoKIZLj2K0suh+6aN0oGatIG4BolsWfodLmPfQxRkk=;
	b=U+CdmzwzPapSw2A0uWh6tnT3Xngqx+H99WmCt1GaERbQBzzMpFXtWpYahdKqPpHeWIHNpB
	vOucfI5ien3mtyLXfHKR9WFRVewTrBJEEQQiXJs9pYaFuQ0/szurDamRuTa6Q7atWuawVa
	2vqJojNgzPjFkkhCskZ6uJCXY3j0Gks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743379741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmoKIZLj2K0suh+6aN0oGatIG4BolsWfodLmPfQxRkk=;
	b=icQ5/v34Uzw+QHuzJHfejRrRX9tqKewI8FagYkWB+xN//nKkUo19GSMUWekcclUT1bNIVU
	ojtfLjliw1Ar2UCQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 6C39B20057; Mon, 31 Mar 2025 02:09:01 +0200 (CEST)
Date: Mon, 31 Mar 2025 02:09:01 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, fbnic@meta.com, kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] ethtool: fbnic: ethtool dump parser
Message-ID: <zybblsg5cth563xrx26jgdsxo3nzvyafrn7nu7wd46vjseaqki@iggq3fslim3f>
References: <20250305194641.535846-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lyawwf7xhbcycxaf"
Content-Disposition: inline
In-Reply-To: <20250305194641.535846-1-mohsin.bashr@gmail.com>
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 


--lyawwf7xhbcycxaf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 11:46:41AM -0800, Mohsin Bashir wrote:
> This patch adds support for parsing the register dump for fbnic.
>=20
> The patch is composed of several register sections, and each of these
> sections is dumped lineraly except for the RPC_RAM section which is handl=
ed
> differently.
>=20
> For each of the sections, we dump register name, its value, the bit mask
> of any subfields within that register, the name of the subfield, and the
> corresponding value.
>=20
> Furthermore, there may be unused blocks within a section; we skip such
> blocks while dumping registers linearly.
>=20
> Validation:
> - Validate patch applies to master without any warning
> - Validate 'ethtool -d' for net-next branch generates ascii dump
> 	$ uname -r
> 	  6.14.0-0_fbk701_rc0_429_g8e5edf971d0
> 	$ ./ethtool -d eth0 > /tmp/fbnic_ascii_dump
>=20
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---

Hello,

the patch introduces warnings (see below) when compiled on i386
(32-bit), can you check?

Thank you,
Michal


fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_intr_global=E2=80=99:
fbnic.c:5679:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 5679 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_intr_msix=E2=80=99:
fbnic.c:5773:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 5773 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_qm_tx_global=E2=80=99:
fbnic.c:6255:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 6255 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_qm_rx_global=E2=80=99:
fbnic.c:6705:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 6705 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_tce=E2=80=99:
fbnic.c:7404:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 7404 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_tce_ram=E2=80=99:
fbnic.c:7535:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 7535 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_tmi=E2=80=99:
fbnic.c:7918:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 7918 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_ptp=E2=80=99:
fbnic.c:8087:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 8087 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_rxb=E2=80=99:
fbnic.c:9154:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 9154 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_rpc=E2=80=99:
fbnic.c:9942:16: error: comparison of integer expressions of different sign=
edness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} and=
 =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
 9942 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_rpc_ram=E2=80=99:
fbnic.c:10176:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
10176 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_fab=E2=80=99:
fbnic.c:10598:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
10598 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_master=E2=80=99:
fbnic.c:11534:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
11534 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_mac_pcs=E2=80=99:
fbnic.c:12251:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
12251 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_mac_rsfec=E2=80=99:
fbnic.c:12619:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
12619 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_mac_mac=E2=80=99:
fbnic.c:13495:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
13495 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_pcie_ss_comphy=E2=80=99:
fbnic.c:21516:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
21516 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_sig=E2=80=99:
fbnic.c:22359:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
22359 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_pul_user=E2=80=99:
fbnic.c:24349:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
24349 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_fb_nic_queue=E2=80=99:
fbnic.c:25416:16: error: comparison of integer expressions of different sig=
nedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} an=
d =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
25416 |         if (nn !=3D regs_buff - section_start) {
      |                ^~
fbnic.c: In function =E2=80=98fbnic_dump_regs=E2=80=99:
fbnic.c:25495:46: error: comparison of integer expressions of different sig=
nedness: =E2=80=98int=E2=80=99 and =E2=80=98__u32=E2=80=99 {aka =E2=80=98un=
signed int=E2=80=99} [-Werror=3Dsign-compare]
25495 |         if ((regs_buff - section_start) << 2 !=3D regs->len) {
      |                                              ^~
fbnic.c:25498:51: error: format =E2=80=98%lu=E2=80=99 expects argument of t=
ype =E2=80=98long unsigned int=E2=80=99, but argument 3 has type =E2=80=98i=
nt=E2=80=99 [-Werror=3Dformat=3D]
25498 |                 fprintf(stderr, "dwords [bytes] %lu\n",
      |                                                 ~~^
      |                                                   |
      |                                                   long unsigned int
      |                                                 %u
25499 |                         (regs_buff - section_start) << 2);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                     |
      |                                                     int

--lyawwf7xhbcycxaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmfp3RkACgkQ538sG/LR
dpVqTgf+JKiPtZ7KaKP+o5oUysEAlapjIGbLqFTWINBaD1yXIBWjJSiU8w6yOy6h
jzUZRJTl/Cghllm01wQ+WWvISqHWylu7F3smt7omD9iY3x26F4DFiNg3oI8MQrmj
kXr8iF5499fqavzPfkixvpZ38PY2L6W2PLuEQ1zZ0eBFKZvEPmqbVVCcXNeqD1GN
HX7tXfvEWtMYdyMIZvRE735Wty9UZ9QMW3yC5FXvHlS+eLT0QSymV3Sun6J/5RkX
to6eGj2PH+w7x+uwJvDQAJu1BYDS1UEQxwVbhnthSv100RQUiwHyShbnW4vKJKHn
jbflWFDvD6bGU/u7Ou2SIIPonBsXMw==
=qdlM
-----END PGP SIGNATURE-----

--lyawwf7xhbcycxaf--

