Return-Path: <netdev+bounces-299007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J0HNBjCZLWpphwQAu9opvQ
	(envelope-from <netdev+bounces-299007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:53:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4A267F3F3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:53:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OexkXffG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299007-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299007-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7B33027682
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49234322B9F;
	Sat, 13 Jun 2026 17:53:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162A27FD76
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 17:53:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373228; cv=pass; b=o0cmtV3XZW5YO2XB1LAo6GPOlZFKfOvFoeTXX0MU+E16CEB0GVvTDPh7oY/mF5KiIwggA/mhnG+wig7pgiAzAHH1HU1GpsRxhuZuIo4ZBVm4HjgaQf9SGRAjyahohlTQp08WF2QLCB4NQKznV4J5M+mpiT3PiKpvMG2Wa66IvfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373228; c=relaxed/simple;
	bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr5Z2ksTNcy3WEg/+6DdL/lXeTK7nbWExQey/XVt7S3VGKFdlsfn+/7XXgJbgEy/UcoUN+VyQZji+Puv2GUXVzZ2wkeudxxpeI1OBJhHJ0paMJV8vmDh3AlgXYUTF09s+oANdmsuJSiq7SIDna0bHpB/pAITw20jhCq1PW06ank=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OexkXffG; arc=pass smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c40397e3caso17678695ad.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 10:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781373226; cv=none;
        d=google.com; s=arc-20240605;
        b=hBrlQjKH4MpqdxVJPYCQ0/1DGyCInxek4D04EfNAfZkHpowpUSg7XFPb9/cjwXOsXM
         OdVOUuJBwG9aYv2QR7NuzDgTQw7Ivzf19NLTeD3yHGJ9oVX+ojV42Qjnde1BUnQFdebI
         8NNCV+8zTewjU+hEDekXCTeyxso6E9YJNl1/7XMQ1e9RUnqCP+wcx/El1r+WaeXa2GX1
         pj7LDOjP0I3Lb+5dzlxWb62cWozeZXwdwlzWTkogOkcZUgPvEvoo+s3Aeg1jY2eS5MBC
         giwa3yKQRi1lUSqD39qSb/XXLvg/Cjx5fGgbQm3mKQ8BDtA22FaTM3Nv+UNBA38Cguzl
         /xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
        fh=7hJrGzSl0Fr0eYzBzc6x5lXWbeKzd4vrf7GM8+h6lSU=;
        b=QiA8pn+lmGd2NLB35du4Nv2KKUp7pdkFmYzyfSDtAv12OiXYQA9b9v9OImYB/L+z71
         avPxXt/FsqUkorMXmJF5FMeAYLldtuS99P4aPEUXjIbdjJIw/RbbLenx76eBBOEumPsf
         Q4vsbuQM8dT6VcDPRsM7J1H2Cg5rpQoPUVucn4Jj+pys4AID4gN/oUaqVnfHVTG9t7zz
         ulaN6f2ZWumh+EZfoWSBz/83uWOUyONT3clf98jxfu/osgKV35dxdaBpwf7aDycd+XbQ
         wBkFhiECr/8ketil2uA7WZA4SFBEFLzxpTuBRgU4FPb20XRiYPwHyqMfhTf7R4EJOeYt
         6jqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781373226; x=1781978026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
        b=OexkXffGeEZa7FMR2Kr9By6VvGTV4HKf7rbZtOaIBuiQqRxP8BqdeFsTAhUYuMDuyV
         wI/Kc9ATBTeWgAqZgvV1dTK32g4Mk8zCJlvW7Q2eTtp4ZOC6PnxBNu1U+XRdXRS8krRq
         19i2wpqsPNlOIMaCXmpmTg7pEnj/v2O3gdpv2q/gMy66OJ5BABTDJFDfNob085tqYtZO
         TFqk/WZRYI7DfWe3tibOPNcjqmqnLkm20pzui/k+w4VOAFVMMsxKwXp1xQMQX8kMsxed
         nLa+0BtxQdKLCkuoQcd8x3wuM02EFZkkfSoWL6UAcdQkiazCIi55W91zx0Y72DoAY4s6
         iFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781373226; x=1781978026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
        b=OThm7z9NglSW1RL5K8jLGkfw8yX59P6hBZRUXbAaWWbthT7AN+JhpHYXNcbRV4ggw/
         aOm6te+ZuIMe2A/kcCRHVMpXC4GTb05LBb6DZ94cax0rFPZiIYFXvDxNk3i29pLJJ4Zm
         PL7f23n7djg3VaRX9vQIp2xumR+4uFbqTlq1IFa05TXrwImMW/3oLOugbJWeGhVai+GI
         SA+HZxa4vPMhm+/6Zw1WzBSoHIuZhMDZHd9GULMFcGATJ7b1vZp5Xm/9Q2qsKEqDnAKd
         KqfnMSlS+Am5+u1FHGoPW3Z8Wypy6ZUILjM0OV6W7MPHlVATMP3gXMELEWyEiouI3HlY
         n36Q==
X-Forwarded-Encrypted: i=1; AFNElJ978COAgpaFTz4x+tqxVoAS65wAkGC9CbU62z1uDzKzUTlmmLFvhb+5D7ztbTCLBl71vC4DwEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuI+8w2PTsUBzbPCd5AYXXmY4UYehfza+qbR8w5RK013RB+ufR
	45AbxND92PU2he6Pl4/COQZR0Vz6wIvU1pba2kRKf22VbQ/LH1a0Jd/coLj1APAv3tN8iAd/uqP
	MdAct+52nQDsPM900NSpeMIDMZKuMCE0=
X-Gm-Gg: Acq92OGj8Yw+rHG82Pj6FSs/+mChhPJn1dlMxA1NsVWFMZacmY1rovfcahY0Y+42/Sb
	baRw6lmBwcUWU3WF86lYkuYhQ7lJH+e+a0qMyUSO4lSZmCyzFAZ32Y6dWwQvv3zZeuUxlaYzp/H
	tmfQ0Q3cIIlprS4pmHfHeBf1u1Nmd3mbDT61NowL69DdFvWHoDCwq1tvWg6cYSlb1fLQiecgMTG
	fmUOK33uCUvmA51Dm396dNO5cgdSjSROd+h4eCo/i7ArbCAaieSFHF0mK0Mj248lqDHEY8GCMSx
	r77SgpS4Z724lsECecB5mlitGfz15ItLCfKR11fajcA6mfZ+0GoS3rbxBKbsGlsy9E989qIx2hL
	fHmRHGcuILmZNAWF2PAVGYbzh1T8G4t6tYAE=
X-Received: by 2002:a05:6a21:487:b0:3b4:b2d7:c146 with SMTP id
 adf61e73a8af0-3b7840eb437mr8380305637.21.1781373226415; Sat, 13 Jun 2026
 10:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
 <20260612114032.244616-2-sun.jian.kdev@gmail.com> <20260613102549.0061a875@kernel.org>
In-Reply-To: <20260613102549.0061a875@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 13 Jun 2026 10:53:35 -0700
X-Gm-Features: AVVi8Cf92xxqHllCzGcs1Wzm4G1Syt1-QC_TVzr88S1xZSnhQVts2Q0JSSNR-Ec
Message-ID: <CAADnVQJyOR0hppTmhbTRS8Sp5ci-L0fmQ6V+R9eiJDop_95rVA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on private skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sun Jian <sun.jian.kdev@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299007-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,fomichev.me,redhat.com,etsalapatis.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F4A267F3F3

On Sat, Jun 13, 2026 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 12 Jun 2026 19:40:31 +0800 Sun Jian wrote:
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
>
> I did not suggest this

ohh. I didn't follow discussion closely.
Do you want me to revert the whole set or just remove that line?

