Return-Path: <netdev+bounces-261603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IVnOo7BoGlPmQQAu9opvQ
	(envelope-from <netdev+bounces-261603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:56:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FC1B019D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2987C300CFCE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC442E012;
	Thu, 26 Feb 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCeowg1c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA23A7848
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142986; cv=pass; b=qI5d6Jbfaadd7yKETIM8L6gkwYA1lf3vgCsbv/J6++Z4QcoR0GiGZx+TKCljZL+YnMefeknXxDIwbvb4zkBFAjS383yy5zX8KmjQwmYqklWwOnbqzaWDBafAVdAqwOP8NmfCC6OvbhpkVimN/J4kIkfzxgUOKvQJOz7skW6rgwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142986; c=relaxed/simple;
	bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3oURMPCj7VdA1osQ+b9YahDiMMcGEqSMitxq7VuOJVDBs39FXe503RjGQaoQd9KfmVZfMWwXGGfRcPV72QjTOhMBwUz3Mfd6FjunZ0VUcubL4InVBVnJlg2n5nvdx0yyoypV0HTsVMurjpnzXAvv25SSlPfOMqSFGc4W5uw9Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCeowg1c; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso10916785e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772142983; cv=none;
        d=google.com; s=arc-20240605;
        b=MZ3I1Yf9KIjGQOlPyK4DpO6u4k1vwlottDVb52rNoRf/HNJ3cKVfmhnSeGGJnb9pJz
         XYKpo4c6E2gjVLT2IiP3+GTH5vnDrRrt/R2rUlhlk7GNLNDACTdwDIJC/gh1qEVnshab
         PtNBX48a5OhJDz0+s4o5GOcE4uVSZvfli+C4bVdo1ZZCDyq6E7sPRDPkKKJup8G8fiy1
         bIy8Kor4D0ldMW3otQ027f3gwBozcsgTG6n2yjxH025stEQZ1Ekc1K9bGXe4trecz4Uy
         1sbAb010f7RvtvS4OSICA4g0u02xrOIVrYLoJsla75oR0V3pPIfx5mSZO4xkbMgfIbXt
         j/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
        fh=npJiP0ujmEi/1GxVT+gMtgQRDV/Em1x80g45fbmgFIU=;
        b=DDLjy4dBKV3Z0CMKK8F9G6hWh0v5snlD9hyOMydo+MPr7EfHR0H3C4wLUNspocxYYW
         ZNat3Q0F3THX1kvuzg0PC/V4O1jhmJGuw3zPlY1/0RrBLvW6D6hyiAjTTZiYAHsqYK/n
         j0YUt+IjOmf371Xdd5N3ZuvJd/SWtek82kbDeGfdVIiD/EGZusbKqWTPdGhYpcRuizXY
         exWpSQD/qRy8HqSoODhVmEpbI5TRlDDaudbOWcYy73zYqiCZDqUfQ1txmEHMUX3zdIe3
         mIC1dRuenG56SHHQHfSm6FGe4UZ3mN4J2iTCXXeue1TFicZDzr8NeKMPvp8iCjS274DL
         qltg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772142983; x=1772747783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
        b=MCeowg1cX8ndLUYIxla17tcyLSPIRd+i1CsmwQtK1o59ili1ihNji3c6suCkkBaA28
         bkbIYFZtrajLMcihfXKGr32uoiZpraHxCOJjohYW0fSPRqYUdnsr5a5tJID7oVXKlBkF
         rRJFC1+ejfbMmVTxhs6p6/cbhUNcaUSCe/PVfBTU4esdwakIijruEzAiwJmdPZHt+7tN
         Pc4G+k+Wt1wpjK/HWPwNgN0Q23W22r1BgnWlIP+bT+awdhNhj/EIMixWBfGBPDC+uBFi
         Kq3dyrTnNxlvoE9rsAYU70IuPq4s797SnVvN4c5Wi34eW/Puoyq3PIbDESyePaYhqfzL
         aGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772142983; x=1772747783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
        b=hHdwchkdcaq0P/Awh/8ukCeV3G8l//2Eipskyy2/ewtNf6saLwpksjlwvdjkeu13jM
         Fhl9kxRYJaZSl3l/p9floVC0VEA3sa95otazVOI0qIbvanaZ7VCX+TZ7tBV8G68v3+In
         En1t9uU7w4N3lRNWtAOUYzdOmRc/43qcmRDupmiTOokRl4G5L1FK0M0X1KiUihu2/VQj
         mfM9MplmnqNk+3iJjPaCOLl46yUD/U53Dc2wuDcHqaES8ue2sbNMreqOjbvFw+Kr+/Yb
         NtnlwChxUgqcDP27kg9Rh2MN3M1WFtGQQApmntwYOM0/cSPwNTwsoFb2hOUHKswX9t6D
         zfYg==
X-Forwarded-Encrypted: i=1; AJvYcCWYn+tYZqiNaB0NMZA3HVc69XErPj/9jUGsq+PAPCKTbtXejf8wWrWxdL+Gcm6FKFkpsTcUa4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVwDd+N3VR+vOSnVuSgXInIydR2HSDruSAfCzIhPmTUdV61Xm
	sOgnjDNZF5qiCCiu4zSHKh3vGRLEFGMp7xihlwvPgEv9J15mx2uYPfvHqXZsF7mmFiBU4RB7qS1
	eCsiSsM4nNFzS5KH+SbaYtYjO9hduVVM=
X-Gm-Gg: ATEYQzw6ZQHa7azpyWw4C44mCN/kBxtrEHe+zaJR/N0sp+zAkMtCLFlr+csUz/eddMO
	1hjbTvusd7ZN68dcWRyjDF33ChmEnxNrqWZyAfEXWzJe39cJqbk9JEJkNm2nY/auXUZL7N8qEiv
	pdo0gS9DyuP1P9l2ffi4acRa3jGKdKPuhPvrbHDhAnpfF3Ikdhio+dSiuZ1wuuAyewCsRWzBHFF
	zHzVt/GnV9T2z7iZoiLdz3FEDal/7i7OP5+07gNvbQ3PSacVJuDID6FtSnsWNpUhfRQ6UZAT/sH
	F/PuRSdkaRVCA2ST6ZC50k1uJmf2tTtlruTOHvLydIVl8s5dxpVuGnK3GkVkGSHtHx3XU/ROGar
	XFP1JLFfWxJhI8KGDj9iv/c83SQ==
X-Received: by 2002:a05:600c:1f06:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-483c9bf49afmr5437545e9.27.1772142983320; Thu, 26 Feb 2026
 13:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 13:56:12 -0800
X-Gm-Features: AaiRm52GQ6X9DvTsRQ_mFSVEgOOXYizMYQZrtMbFf9A1yKUa07ng9nh92m8C2EY
Message-ID: <CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261603-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 662FC1B019D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 1:16=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Previously we have attempted to allow BPF users to attach tens of bytes o=
f
> arbitrary data to packets by making XDP/skb metadata area persist across
> netstack layers [1].
>
> This approach turned out to be unsuccessful. It would require us to
> restrict the layout of skb headroom and patch call sites which modify the
> headroom by pushing/pulling the skb->data.
>
> As per Jakub's feedback [2] we're turning our attention to skb extensions
> as the new vehicle for passing BPF metadata. skb extensions avoid these
> problems by being a separate, opt-in side allocation that doesn't interfe=
re
> with skb headroom layout.
>
> With the switch to skb extensions, we are no longer restricted by the
> features of XDP metadata, and hence we propose to extend the concept of B=
PF
> local storage to socket buffers - skb local storage.
>
> BPF local storage is an established pattern of attaching arbitrary data
> from BPF context to various common kernel entities (sk, task, cgroup,
> inode).

And that list of local storages ends with a solid period.
We're not going to add new local storages.
Not for skb and not for anything else.
We rejected it for cred, bdev and other things.

The path forward for such "local storage" like use cases is
to optimize hash, trie, rhashtable, whatever map, so
it's super fast for key =3D=3D sizeof(void *) and use that
when you need it.
The life cycle of skb already has a tracepoint in the free path.
So do map_update(key=3Dskb, ...) when you need to create such "skb local st=
orage"
and free it from trace_consume/kfree_skb.
Potentially we can add a tracepoint in alloc_skb,
so bpf prog can alloc "skb local storage" there,
and to clone skb, so you can track the storage through clones
if you need to.

