Return-Path: <netdev+bounces-299059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U6coKOXQLWoxkgQAu9opvQ
	(envelope-from <netdev+bounces-299059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8367FD58
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:51:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iGG8pgq8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299059-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299059-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9468A301CA61
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6C3A5E64;
	Sat, 13 Jun 2026 21:51:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBB21CC71
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:51:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387489; cv=pass; b=AaL6kjOs2r3U3t4T9gOcnDEj8jzjfdL2oJcBBAN7pV48lpwxODIypjTRDCHiuMV1Pc9/zbwESy9nKPyWyX94i3ez0d02tTl0OCO48PZBNdv80/aIZnzAa0WMSxUF+TkSKpRdV/GkgaSPmpbcgtPm5htvm/g4JwWhmhwWbb9IsWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387489; c=relaxed/simple;
	bh=mPkbJfwqW05tsF63Su/Xy32Idj+u2NE47UCfAl4A+3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H154czStXk7lUgX9R2PtEWb8DlHK9eXHSs8maCTUjTfN2dv5ObQ1rGhhd4AhRrcBgKSxVE70FoUlUQJ36eDnKrmbZJm/mA26liJ1Seiv5JL1eAblzZYTy698XH5uXTJ/iXnGZ0+TawRUlsfRrSSnZj3+KKNnu+gh0hDN5W7H4D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGG8pgq8; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so3561341a12.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 14:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781387485; cv=none;
        d=google.com; s=arc-20240605;
        b=UyU0ezWLJpzJp3sT3jMNPK9dtBvSgxKzO7UBsIpvbWEzvgQgXA5cga+8TuaHfY6zvq
         OwXOlRJhcUfidUkO7aF2/o6DfJIhz5OftxKC3VXYVCfbtKVWs0+jPksbkWWDsayporK7
         slNfM02hmOrTG4hkMkltC8+IN0QOtFTTGHqriSx40thrf9Uo+B4ZdIm87vwfZf24oUG3
         1MHOlbjW6oMPylcPduMZPwjjbyCkHEEmikXKSaJekSjRDa93I8Di3czQeHtnppVQ2dDL
         udlkee8woTHYS+41U7hfzPZYAtJdeWL+DPQxSQGqOivl87ko66e9HA0PZD5huH6AXVuo
         4haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mPkbJfwqW05tsF63Su/Xy32Idj+u2NE47UCfAl4A+3Q=;
        fh=6I3ude9wMR7idfIeGjWK7Fm8WsMJbzuIOp1kZUuQ4ls=;
        b=Fmo7VUEtp/G2AzuQkhZ2Q1/WPxABPBJAVU3KcwrkW318U4ZBUjYhyBbI7JsUyEMB6o
         iK9LDHhnWggcrUPHrHp0YKETK+Sfsk8EfmdhFpX5Moe26nmeIcoRDQH5+pTAGKfXrRac
         wqNknK/9npCI4SKRDy+4wSii84AcOIVtNwKZR/aVSKP2KeyDuAkTD6Er3ujdXYpwY/zD
         rUhNBTrZBTDRTZu53PtFX62/oEOQDBe/g8jY9/LX3q/sA/6z/kqdyw8o3LsrwvWky4TT
         m+8/omG//ZX5hVUYSoT8xV4td9kib0DEppZ1mcBLHHCZPVp/usE+qUT5uajdEYKn+WoS
         dLjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781387485; x=1781992285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPkbJfwqW05tsF63Su/Xy32Idj+u2NE47UCfAl4A+3Q=;
        b=iGG8pgq88OmSJp/gsXtvwZiNsNWbJ/oA/anS243Bac+98+B1h4ES7H9p32gO+BnZl/
         kovMwGFF1sXDPksAf76/mcH0PazcjnXX5x6ZTZbYIkiO4Q4gRchiw9ssfvoul5OjtuiF
         XdyXEB2zUs35zt7wXlKWFWwb/q6WNEAQizix4fGJCXpyxKi2SbWtw+6RWqtBq9lJBiv/
         15VacEXozZ1kX/5+xOdZLnxYaaMsOwh0OeI94ni5Ild5HSS7GgWZC2Gvo+V0N+gvKKJ3
         yQYqn6ZfAu5QvRbyIvjjRfchdBfnSBaUavX/lJp2Aju7Yb6FfftDEXQOXpp+6qhxj8F8
         VssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781387485; x=1781992285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPkbJfwqW05tsF63Su/Xy32Idj+u2NE47UCfAl4A+3Q=;
        b=LT0/uH0pjqt2YN7PDq0nGHXjrk+o5Cj9AeLo/PnDYoBgaFJgsaP0hMNtirDQ9Zwc0K
         PfpO/mzZdj3m8Cb8lpbLSFjHbvhaah1y4AMkTFophi6U2RSKyiW3YRm4uEdQyRf5Z2wr
         7aYEf3Arld7b3PsJUdx1FML3pPWgXUJj5iu9mbWr1AxNPIVXHw+xTIN8dxnjDFO1FTjz
         hbXNF8lcvfiXxRmFvuKQ0wkilDO+dl8qjyeQYEeQUWE3j0Sg8fkijdmNzNGPj5l3w916
         GFRD4+8DdsOS2QfU1NpileHYnO65IMHJYFADoUJ0DYB2U7QzYbeIChYOdnRVsBFxAuUZ
         Q78g==
X-Forwarded-Encrypted: i=1; AFNElJ/lJjAXmvGts0Y2PGk7zqcQOX0mQvCQ135PpnaufYjjDsGHibBx6E29SKEe4Bc5eesbF1flaOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnQyVEhdM3WYQUxEbdvcO5gBMtm4g1BSSEXryWAdoJQjWtaLr
	wfeLZkEPqiEFda+HRARERByFjoovoZI800LaPERQpTeWLDq5AeOubKaU1FtlsG/d/n4fGHRzjUV
	C1xiL8dEpOz0k7yBNPYQPTSegDynEoTM=
X-Gm-Gg: Acq92OEQnZzzqDXeOKE/67c8hNozWOFLyyugsPlWkLW7QpZs5WC/b9CfRfvhmhO+L30
	dptQIMFmiaOwQT8q477S0nIs1RJ1Esipm6jDNK7q3HrHz85S7sMVBWX1fzJPdkubaTXgtwh+9vs
	LuiF54UITc4mYJbNsNaoZOBuWnbsyZYHNmpcwHAG9N341Y9+mwdfGZW9OM1XzIMsjewKNVSUryf
	KJfT9/5udVV+RsglxPgncSP6owLHx6NQoWvFJq9nga6C+w4EaY1zTTHZqQNTiIr+pex+amU+ZNJ
	C+/cn1STTFrI7r5Z3FfPQE+SSBKOGfh3Vxpij/Uk
X-Received: by 2002:a17:907:3e0d:b0:bec:fad3:5b58 with SMTP id
 a640c23a62f3a-bfe2a11ec36mr394999466b.27.1781387484755; Sat, 13 Jun 2026
 14:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org>
 <20260612-rtl8366rb-improvements-v1-3-9232286fc20c@kernel.org> <CAJq09z6oPRAsF2QCD9n4HjruHvE-nqanYvP1CaFVDn7sg-ef6Q@mail.gmail.com>
In-Reply-To: <CAJq09z6oPRAsF2QCD9n4HjruHvE-nqanYvP1CaFVDn7sg-ef6Q@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jun 2026 18:51:12 -0300
X-Gm-Features: AVVi8CeXc5G7y6Y0XoCk9ufkL6ul3FqL-uNP-D78ZvJ_Fs67E9trNdYjECY_ke4
Message-ID: <CAJq09z5ieovPbpRoi73vh0CAUUEZngkvB89RP3LRcP9pWvo9iQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dsa: realtek: rtl8366rb: Disable STP
 learning on all ports in setup
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00B8367FD58

> Hum... I might need to check rtl8365mb as well. There we disable only
> MSTP/FID 0.

Just for the record, I double-checked rtl8365mb.

The field rtl8365mb_vlan4k.fid, which is currently left as 0 by the
driver, is actually called fid_msti in the vendor code. We should
probably rename it to msti if we ever implement .port_mst_state_set.
However, as it stands today (always defaulting to 0), controlling the
STP states only on MSTI 0 is perfectly fine. Hardware tests confirm
that the MSTI 0 state accurately dictates the port state, though I
haven't explicitly tested if setting vlan4k->fid = 1 would actually
make the VLAN follow the MSTI 1 state.

Regards,

Luiz

