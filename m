Return-Path: <netdev+bounces-300644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6vzgCjnzNGrOkwYAu9opvQ
	(envelope-from <netdev+bounces-300644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1E6A468A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XOzkHvai;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=cz2Gxtup;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300644-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300644-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601B530276B9
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E32D662F;
	Fri, 19 Jun 2026 07:43:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32943546FD
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:43:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855002; cv=pass; b=um1shjkyvNZajZR3cBMFx2T6yDxWONFfodrIRHvIhhUN6FPtPmaHFY3utUWbblU/7fJEwpf4LE2DP+fv3f/lffjZOCbuBL8XCEfsid87yHPi1RSdjjT8RoFYrBex+rb/LuO1mODlVRcmmQpW1BzVOHB86aKu/OmSXkwdDmt/FbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855002; c=relaxed/simple;
	bh=BwC+zSDwMurC/uowEgSmcf2jxbCSY/aI4Bw6gwZLfwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOaQRdUYHSYzckn/BnM7PJlt0MELlL1q6uvhruYq393KL6WB6r9joxxfXJIzsJFlmS0ddzP3v9t0dUUv8IQ/Ctvrbti7q9tdyeOT1owsJwa/BOP4BZhapVtc0MnM7UclN5rkQpUiTez9Jrau9sIzY6SUrrZrnbOl0uwD9Nryz/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XOzkHvai; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cz2Gxtup; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7PAeW3738909
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NL40Xl1rFXjxLbLdur10gnDx9HQxQPwUu/ZXmYVnQJ0=; b=XOzkHvai/f8Db6sR
	Vu0Wr4HStAPyOxYSSNHeps7wkwl2S0HgRaFF1bhSMo2NGk5MBMj16y1egcUx36bV
	R9lPWUQOLK6Rh/L1ydmMsnoViBR0n2+WEwZ9MX+ojnS2HNdqKfKNe9DVEXDML7O9
	11wL+mHWpQtzEaLMXiF2eRthXRJptZNqxNXA/9NdLGZTCu2NUwH7yEAF5/YNXC4R
	omuUTPwU4iywPZPhuRzjAxYEJ9WpxYViGRSXZwchzVE/KF91thDAodCWndunr33S
	b41GtyybUpsp353TEbhnHzlyD+YYOzk9+B9sKwez+t5+K+bJgd+qbR+C8OkXzgZh
	dfLcgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm26axpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:43:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157f1be083so339639385a.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781854999; cv=none;
        d=google.com; s=arc-20240605;
        b=JO+72SVmjhsvN6efqNb/WW7RiDtpTLnPQvDDh4tGJ4WqqsnI71myq6oHUuFv2lJb+b
         uUlAKK19VrC5SL1Hb0Ki8kada4m9gOEvKr/hZvlcFVpQl6CPyc4T4Hpz1n7rmx171dXU
         XlsKwIkhXBKtu9jzTN8QeIolb/+N+9LpXbSOgYQDfaYzzyRtt6ReFnLV4l3usRSVXj2W
         4a7mLTlIglaOt6gfJ8mmUqFtzTV5n0wvGrOJjnkDYwFdveL3BIgxxKZMNytNLkzIlUjZ
         DCYrTeEhetZ4bIxn0YlfPwYCLgZiGgv1UzSGXqeY9xpUBgWx8uonsKFAVmSBbiWlOe35
         abDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NL40Xl1rFXjxLbLdur10gnDx9HQxQPwUu/ZXmYVnQJ0=;
        fh=OTFe4vX6UcOeof93YSrLwv3A260ctIk5dmWmZhO2URc=;
        b=EB6DlFagmIN4rnFVV0b2s+R9+svpbx86cW6++KiVd9cW7AUT/SYD5LeQG+4GR+dXpw
         dLs8BZrIDXDrTqwyCCqVM8JZcKjmlMBWA7KNBobAeRayVYocah14vNo9xkB7LBetwQdw
         phIrvifp83W+rXvOXe/V51AMtpgw4ouFpZj9X29ZIS8OQyC7w+2DlbRzzuuwvtQD58w1
         4PuMfZgvY/hzE/RLAUBMl/1Uvl2aR4aAhzjSWUYz/CC2z7+LSTFddcCiaU3UX6tWbGhC
         R3uTkOkqCPj/p2zbyjwuo9h7Pfn9NYQA8xu1ERBWzCv0kxtL2ooGROEKQDL3LCmQI+Rj
         qMog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781854999; x=1782459799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL40Xl1rFXjxLbLdur10gnDx9HQxQPwUu/ZXmYVnQJ0=;
        b=cz2GxtupBj/01IZHeIg7cFxyvrBZnplD2xo1zxOx7lRkGtOlBK+v6E/x/+8s0knL28
         R6ell150kMYqSrYtXntp5hjdubaVPNvSQukE9lUbST7aw9tn6I52OTO7p3O/qa9K9GUR
         7hmvv7s6NdsxalzvHotSRr/TdR7ZcxrUJhyg9/WDYHlOSNzQUfThFDfUKPZxaFqOKjEJ
         n71SqCdXC5l6NAtp5PlkoemhUNIMHkNXDfMMP+APHRZwtr0/zdoCwID1GHjjomAr7v43
         uHyl15IR0iE5Y5VQy7bMt0nrRpfdymXmvuQU3veoBnNvugtOdkfknbRcZlnztQQ/N/jk
         PD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854999; x=1782459799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NL40Xl1rFXjxLbLdur10gnDx9HQxQPwUu/ZXmYVnQJ0=;
        b=SKvyUarIhRz7vHwm1rVtClzkrfa2I5Z72VeSxAZgiWO9FAOnnUz97CYr0r326STYk5
         TnG+NfF/PWl8edtwHN/5b/TJvyL9N96FuffolTRqJ78VK6Ht/6sJWrrr/UfsGy1PxdHR
         0ZzEj0Q0KA9d80so1jA6xyCdl6pP81+dxktdRSlM9fWid+oeA1sEgRmO3W4f6k8Nswp3
         Ck98YY8HG+KQaNKGu/K/T75qr8Ov5PPKZncUm2qj0n25r6hW4ECe/g5ODUznttTyvXIK
         1MJfculpVHMDacog9NLvZx8bHL9m08kE1Lghb/O/ShlYY+lRl1Ed/GGd5hxiHVrlI8uk
         +M4g==
X-Forwarded-Encrypted: i=1; AFNElJ9YkypoER8Ih8wTgXWAdQWAftrlPoVtQIlFtsPPvw+09rR74ycL8vnhcqwxTX/7t5M1ZCgw5xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljlzPVVgaAn1QP7alDF9A4kRn7OVr54tjnIQGJ8E97t9pQvkC
	IkBcUp04MAsGgDEEmolaCtSJDNWRe9gsJnhXenYU397yMXB07L2kyjXAFhrieFS4rPjnt9JO3Fe
	1sAQc2aTRiNkjkPd7rV4jqh4pXp52N+JW5g92D3WFX5HQErai5HmjzL8GdnUGV92SBh0U4vrKi2
	io1JMFUW+dzsY/5HX/kzXPVBDJhWDhcNbuRdLwQXGP8IE/xv0=
X-Gm-Gg: AfdE7cnZuurJJqfAS4ZIVb0iBRFh2xkkC1F+j8ft3IQSThhPtHVSYJgYbOb1BNc+cVC
	AhOsMpt2SB+/7drtsKTXE7ShFHIZyenjAlfBCFhLEZd5jfwt+YPy/lVcUrh4pxWsvB/0DMNCqcb
	thzCCzmwd3gpnzDqCTH0N6kNezGDi7zi3rA2NA2tF8ZPwVfyu/9X6j5lZKjfHLK8ojQNDbEIAji
	oPOXz3styUclQ48H6aZWqMOfGwXlXKW2Lm/XqdbZTuNYzUiCwwxBHUw4OwGNjKbf+YX+f/rDJl2
	lCb2BKqkaQ==
X-Received: by 2002:a05:620a:444d:b0:915:9fba:878f with SMTP id af79cd13be357-9208e981e36mr363373685a.5.1781854998793;
        Fri, 19 Jun 2026 00:43:18 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:915:9fba:878f with SMTP id
 af79cd13be357-9208e981e36mr363370885a.5.1781854998303; Fri, 19 Jun 2026
 00:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178183832043.3878023.3610072137230679925@maoyixie.com>
In-Reply-To: <178183832043.3878023.3610072137230679925@maoyixie.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:43:07 +0200
X-Gm-Features: AVVi8CdH_JYBitOCl9s_8zw6tlPaGcQn8okuQfpjRaJJoXjILeJIYvjFHC-FmMk
Message-ID: <CAFEp6-0HD1MB9DH7VT1ohjKWdo=0xyDMgg+RJ4FqexUx0qB1WA@mail.gmail.com>
Subject: Re: net: wwan: iosm: possible out of bounds read in the MUX downlink decoder
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3MCBTYWx0ZWRfX/KfUTZDuYrJO
 38n95uKoTkR2G75wgAWjUS9trmmK4VynenkhSLB2hF49sd50qjYbS6//GVNCeu4uclyMVvTdesb
 F+Z16DYUsf1f3EaKhiCFmr3T3vbR+74=
X-Proofpoint-ORIG-GUID: BH6IZZwvMtC0PrTbC_dbu21nARVrHo01
X-Authority-Analysis: v=2.4 cv=dL2WXuZb c=1 sm=1 tr=0 ts=6a34f318 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gj1R0zXSaysYn3ly:21 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=SnhycFdtAAAA:8
 a=pGLkceISAAAA:8 a=PUwBNI92zle5_T0wsVQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=IdunurJ9zWQ3aaQyNLvr:22
X-Proofpoint-GUID: BH6IZZwvMtC0PrTbC_dbu21nARVrHo01
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3MCBTYWx0ZWRfX2Q25dLGfCKGD
 vGHxvYCsCdIlzarT2FZQQCzb7eoF6qDIOcC8bo+21ULFbWqp4aoG9lIhxMZ1bi6AokGrt/ILu3V
 WX2B1RrCfysgmhVn8O+4cfcofExVKMe8tzLaMkIQ2adq6S9FbZWfem/3WwCrvZr2HQpl3+hFXsz
 7m18QzWSY2KB9gm4JYCxKkFHx8L8i4k07FVTinwV4dy4VUOCOl3DTBg6T4R/o5b/i3kGROw8sBk
 046ubhllbmv93ghZ5UHNCTPahUFCeW2SaxYjhM5k3t77UQstCx2OezohHNlYLqx8SwhqZhiY9jI
 Ebymdbz6X8EKC1p/aqpQrH/+y+MEMZ1Mf21V15I54JH1961PYBp5L0bsayCvKbATPGqw6XujsQG
 8eGci4KRbDZBYjsnod7CpGhq6TtydAP5acFd1CfsXUuDNdwwlq/+aC7Wtw5KHQsWAZ0nrhq1nY6
 T3jOGDlvefNXUrzeivg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190070
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300644-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,maoyixie.com:url,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88B1E6A468A

Hi Maoyi,

On Fri, Jun 19, 2026 at 5:05=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> Hi all,
>
> I think mux_dl_adb_decode() in drivers/net/wwan/iosm/iosm_ipc_mux_codec.c=
 can
> read past the downlink buffer when the modem reports a large table index.=
 I
> would appreciate it if you could take a look.
>
> The decoder takes the table offset straight from the device ADB header.
>
>         block =3D skb->data;
>         adbh =3D (struct mux_adbh *)block;
>         adth_index =3D le32_to_cpu(adbh->first_table_index);
>         if (adth_index < 1)
>                 goto adb_decode_err;
>         ...
>         adth =3D (struct mux_adth *)(block + adth_index);
>
> first_table_index is a device le32 and the only check is that it is not
> zero. After that adth points at block + adth_index with no upper bound an=
d
> the code reads adth->table_length and the datagram table from there. The
> downlink buffer is IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE, 2048 bytes, so an in=
dex
> past 2048 reads past the slab object.
>
> mux_dl_process_dg() has the same issue further down. It reads
> dg->datagram_index and dg->datagram_length per entry, bounded only by the
> device block_length, which is itself never checked against skb->len.
>
> The protocol layer below only caps the total transfer at the pipe buffer
> size and skb_put()s it, so skb->len is at most 2048, but none of these
> in band offsets and lengths are checked against it.
>
> The data here comes from the modem, so it is device input we should not
> trust, especially with an external or compromised PCIe baseband. It fires=
 on
> a normal downlink receive once the iosm net device is up.
>
> I reproduced the adth_index read under KASAN on 7.1-rc7. With an index th=
at
> fits the buffer the read stays inside. With an index past the buffer KASA=
N
> reports a slab out of bounds read past the downlink buffer.
>
> The fix I have in mind validates every device offset and length against
> skb->len before use, rejecting an adth_index that leaves no room for a
> struct mux_adth and a datagram that runs past the buffer.
>
> Does this look like a real bug to you? The aggregation decoder has moved
> around over the years, so I am not certain of the exact introducing commi=
t.
> 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support") is th=
e
> broadly cited landing point. I am happy to send a proper patch.

Yes, please submit a fix. This looks like a typical lack of boundary
checking, we should enforce proper sanitization and avoid blindly
trusting firmware.

>
> Thanks,
> Maoyi
> https://maoyixie.com/

