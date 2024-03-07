Return-Path: <netdev+bounces-78374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D77874D4F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7381F2581F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E9128386;
	Thu,  7 Mar 2024 11:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74E86AC0
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810591; cv=none; b=AMra6hNggu+6WoL5Un6m2Ap2+tMVksLtgRiMhTj9zTxutAvKOneguzNxYf3rHHSopjBfji1qQk36zHMhQOgvOXZKF47PmPjgF3hzK9QbztckfpKCRIDhEAOZdGKe00cpm7BnwGP4NVbE0MEH95eVWkWQsi35ox4LUG4CXUTtYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810591; c=relaxed/simple;
	bh=+XjrPdGpHZjXsyTcqJrPsAAYV4LNNtyw9XVCixuP6Dc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=J0E5C2ZP5IIoHHmeso49VofZym8aigfdONIN5W57EWQC/Qea+2RCoFEquJgr7+sxR9Xqj+qw1DO3CdfzQEbcn/URIwoFsK+K1YONOfu5xM8KIW8Qmt3l9bcUP2/j8F3Z/wtpZnM5be0wGYR6rk4oWxFMteqkmLp3zzOVY2c9rco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 59D497D125;
	Thu,  7 Mar 2024 11:23:08 +0000 (UTC)
References: <20231113035219.920136-1-chopps@chopps.org>
 <ZVY9Bh5lKEqQCBrc@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>, Steffen
 Klassert <steffen.klassert@secunet.com>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
Date: Thu, 07 Mar 2024 06:05:37 -0500
In-reply-to: <ZVY9Bh5lKEqQCBrc@Antony2201.local>
Message-ID: <m2edcmz3ok.fsf@ja.int.chopps.org>
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


Antony Antony <antony@phenome.org> writes:

> On Sun, Nov 12, 2023 at 10:52:11PM -0500, Christian Hopps via Devel wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
>> (AggFrag encapsulation) has been standardized in RFC9347.
>>
>> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>>
>> This feature supports demand driven (i.e., non-constant send rate) IP-TFS to
>> take advantage of the AGGFRAG ESP payload encapsulation. This payload type
>> supports aggregation and fragmentation of the inner IP packet stream which in
>> turn yields higher small-packet bandwidth as well as reducing MTU/PMTU issues.
>> Congestion control is unimplementated as the send rate is demand driven rather
>> than constant.
>>
>> In order to allow loading this fucntionality as a module a set of callbacks
>> xfrm_mode_cbs has been added to xfrm as well.
>
> Hi Chris,
>
> I have further reviewed the code and have a few minor questions, mainly
> related to handling of XFRM_MODE_IPTFS. It appears to me be either some case
> missing support or/and in a few places it should be prohibited. I have three
> types of questions:
>
> 1. missing XFRM_MODE_IPTFS support?
> 2. Will XFRM_MODE_IPTFS be supported this combination?
> 3. Should be prohibited combination with XFRM_MODE_IPTFS
>
> 1.  Missing:
>
> a.  wouldn't xfrm_sa_len() need extending?
>
> I could not find support for XFRM_MODE_IPTFS explicitly.
>
> However, I'm not sure how the following code is working when xfrm_sa_len is
> missing IP-TFS xfrm_sa_len:
>
> copy_to_user_state_extra() {
>     if (x->mode_cbs && x->mode_cbs->copy_to_user)
>         ret = x->mode_cbs->copy_to_user(x, skb);
> }
>
> I have attached what I imagine is a fix. Check with Steffen or others if
> this is necessary.

I have adopted this change with a couple small changes, thanks!

> b. esp6_init_state() and esp_init_state():
> These functions do not seem to handle XFRM_MODE_IPTFS. Would they default to work with it?

That's b/c IPTFS uses ESP w/o modification. IP-TFS makes its own mode based changes (similar to what `esp_init_state()` does) in it's `create_state` callback which like `esp_init_state()` is called from `__xfrm_init_state()`.

> 2. Would xfrm4_outer_mode_gso_segment() xfrm6_outer_mode_gso_segment():
> support XFRM_MODE_IPTFS?
> These functions appear to be missing. Is it possible that you don't support GSO and GRO?

Correct.

> 3: Shouldn't these combinations return error?
>
> a. ipcomp and  XFRM_MODE_IPTFS
> I'm guessing that ipcomp would generate an error when userspace tries to add an SA with XFRM_MODE_IPTFS.
> ipcomp6_init_state()
> ipcomp4_init_state()

Correct.

> b: In xfrm_state_construct():
>
> if (attrs[XFRMA_TFCPAD])
>     x->tfcpad = nla_get_u32(attrs[XFRMA_TFCPAD]);

Can you explain this more?

Thanks,
Chris.

>
> -antony
>
> [2. text/plain; 0001-xfrm-iptfs-extend-xfrm_sa_len.patch]...


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmXpo5sSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlUJAP/jEFqCAt0Ik9PdX1OmmgWZwJqmmTCRsX
frKB7Pb83h4mb4uHoi/7S4QT57fW0okIeWbaDNoZFmDS1kK8EuCbZ/BYwqL6c4wc
Mu9sazYXg0QPPq7n7oLrjiw5Bi6B0ANE4w7tClOuTDtGYSuSPjYUzWGoNA+c0a1/
HjTYEdkIrQDFs599oTQ8MmUQlRKaTDJiJaEgez0eCb7eempMjAGDDET1XQ7wha27
RhYUS49+aAllD7Gd/n+3i0k9m3peabajFMl2OcxvueWj+0cr9Ggwls8+Q9FQL0NT
4DKJWMguoNm0TzDaeLrBD2flm6KhOmMmNstgrIKQzTGUp0cHJaWdrng7cnavsIZn
Xxb81F7eHrEr42stpeV0zMe8BSM1HdAPniRs/Vujo+n/gDKOrpEQ7I4FG2SEzu4m
kKL8BZMkh4ve+Fm46G+Ytxxke1hBM0Qjbi3UNIvXbT5Rud098SLXspj5Wy7vVDlF
LlbXR969kKMXs3hh8y6sk5kFTfoZc3YUZB7+CZhg0XxMD7QXKE6mA64YjCv+o8VG
XJgzYdhXjKcfh9qf2mzA97X4NQX5ltxyso3fEfZZDY8TZGXr4SIGIyJ0eDbrltTs
MsRb8vw88kyeqXWTf711EVfFfV3W6gYl4L0bjqKR26H+Lw18XIvm+HukbqVwXSqD
bogdZUdPK4wF
=vTt8
-----END PGP SIGNATURE-----
--=-=-=--

