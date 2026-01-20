Return-Path: <netdev+bounces-251581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JipK1fZb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:36:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5364A930
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5680454B255
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A647798B;
	Tue, 20 Jan 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1twhqfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030845BD5E
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933332; cv=pass; b=i/B3I0qd+v5kg3q2misyvGyQ/T+VhJ/nMfQDhpeyDntd77BAaOy7bqZJLCnPWC9MjlL5FwCRMV+fOJmsH8pibzGUxzfYSHRxDlTSjqIPhqLama7vH0/NIs2wEoOS8JIjt0eN6k63MLAEDmCjf+BsX9GPDTp4xZl9xUim4ojvsOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933332; c=relaxed/simple;
	bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0CAjju2FKop3ljE5HEhnYulk2TK43kkv2g0pZ308ZHhbW8kI7ZRq+eqKnYfeqll67OGVZeMTDwIrPU7gQSvzGcRSA8fYo4brFBQinZTkajlQz13SbxXSs0sQErwST5p2izw/XgDavIfVSNYqM3PULSQsxw6YGkR7+bmgRtZ/Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1twhqfN; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c532d8be8cso533347185a.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:22:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933329; cv=none;
        d=google.com; s=arc-20240605;
        b=ix782x9EwhH1eIkIa/gNZ5qgRVu7gbUi0Upx6g9UDV5g4gl7keZfPpL6bOVJXSWVmI
         KVk6pIgZsboK/jYgruEjB46bdH6sMJn+t60gBbhNSMJ4+x4DCsIYByqaoNe/0mmtgSUn
         OuydiCsmhbSKIOGKIFeDzomks0fXGA22oY3mJsx0lTSeMGXzUn990HrXLBX55lihV41d
         QvXYztn/7B/qGe6RCORjIceCySUQqUyNxlQI7YYnxAA72HkBNOdgE6cCBncu1+S6LS8t
         QmDmKbJHWDCdMcpZElC9CgokfjE0eYgWP+O2FCq7cYEjVSwDQOk5emJydnBGXLGwftgQ
         mZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        fh=QMH7KRgvv5g3PA5e35Pjv8+fvY+pC83fpPrxhvINKfw=;
        b=PPPQQSVWR9E5BAP1Yb4kmkpCfCPPzM74BmmCw9Iac+NI3qRZrF3hhrMVLK4LpG6+I0
         nJtIKQVpwiDynpcLuGvbqbqUc0ZAuQVs1hy9AQ3SGzNN/bX+H0W1sTKsTjBbEhRqZAqE
         caI1ZcKlyejXovP2Nt/Jjcu5+E7BSoYXmE88n+XNVqk9ydMa8aerZWp0up1YboMQnLhD
         ONESgjhtDKsIf16XaDj+NL3NeO5B6zQJhhDLg+Shl+yJ1tJ/a+NGAZOZU/q0miwyP8QB
         Hl8c7XrP158Heah8081VqlzPzHmttOYWAbG6pN5awdsNjPHGhQPj7cFrKqTY2+q4QLs/
         D0HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933329; x=1769538129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        b=V1twhqfNQgxIqAL86UhV6eZ5ewl1/+v1oclnw3QqGrQ+4Efb5K5rcNuQwnoPMEk/iM
         MedsZuiGr2botbP8R9adTT78c99XtNZ0e1rcB3fkasa3i8QT+wtFnUypT9PqHmc8Qi1f
         0z555qgfXkq+ft1tx7Ki/WOaJAyQZrqM+Af6/YSYb6fImgkhnSnQPw5dnlYmRDkYunlI
         py5Sj9CvGbgStbZrcTxi/AUJIXJjqoBjCh6//Qls/ZJG9KBuFNTA7+IMHa/W9ksBidi0
         HstoMirl5zMXIwoUKPrDf1arq8oeiNJeXr8KuSIvIlfhKahPRUAPph1w7tsS1pyTcjKm
         b8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933329; x=1769538129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        b=oM+cXuE2VZdYHIFeawnUTsVuKuhtk0XYyjcn76AK71M7a9aRnYFA011EXD9RfjO2LN
         V5RR3lxpyZYZnL9paY660SzXKiJ9u7jYbJ/ePUcrzPpun02FBCVOPs6DF995OzMLuCT8
         a3riYKlzhM/L7+C9MH/rV1IsqlEDq+XLV69ePo8H8THX1vv92qnvhiCfq0iLEwVWGNUP
         USJdWs+SjHOm/acIL4vvH5cSj55R+xJvTzg2oMlPDgIt3P6KVDjl4XrvKJAiNFy1DjG1
         uom41xIDyqJD0DNRFKV3wJSO4kB33l8W5gSWs0uGgtlJeKmyqBXVtYW52szMM5kjJE1i
         zubg==
X-Forwarded-Encrypted: i=1; AJvYcCXBl+xIlUZdu01vcL8LbfQhrbau+XTqrdKnQcsKc2fKAxLjMSialfeuCbXl2DS2K0X8MMp+lzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MXMwuE6IIbVN3TFt3N46Ve6H/rkFC+PK8imaXNenxYvmEOlv
	sBynv04zRkI77mhp1pxIwGNEma73/3Z6e9DeXaZ2MurZqmVozSvIF6fpvfTqxm9O583f9CAQ3wL
	1bLrz1ALYSH+LfH2mDG9z+GKewrphKPhes2kBeqop
X-Gm-Gg: AY/fxX5RFOqZ2BAzZDP/5S0Rq4j/7G6KtOS0CZdGq0rYVPsBu8GYO3Pc0Ch4c5ExnQE
	JGWl55XKeh9xKWvuIU1xm5vqBdgkcHDvSQjVlw2ChltSrxJ/p3vQEuqIRaHIcnY6mG2OIm2v76X
	w0bdONE9X8OoEFAgHkY7ZSVBnQqR5L6z2c2fHiirxUbSCe0NxoU1gfykF30UgemDFX2Jl28694W
	2HI0VaeKWCffyP5vygFAtkln0yrA9C25VSJBwxy4b9ZghEiokItHhNswiqiNeDq/tfIXj7v
X-Received: by 2002:a05:620a:2947:b0:897:56e7:6aa3 with SMTP id
 af79cd13be357-8c6a676db0amr2122139685a.56.1768933328887; Tue, 20 Jan 2026
 10:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
 <CANn89i+NEyZ+1R1pouUcroarCfNrQEN01azsEhOuZoeR0Y3mhA@mail.gmail.com> <PAXPR07MB7984E2D22D4337CA97EBB9CBA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984E2D22D4337CA97EBB9CBA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 19:21:57 +0100
X-Gm-Features: AZwV_QhBrdPdlMbRCuth_kzLC6UfgC6v0TcEzAFsayFTN8n9oL2sLEky-qL_slw
Message-ID: <CANn89iK5jhfO7B1yZK11bEs4DyF3Wjfr6DUgOt-JMDzEAs+94A@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "parav@nvidia.com" <parav@nvidia.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251581-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 5F5364A930
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:11=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
>
> Hi Eric,
>
> Thanks for the feedback.
> Do you mean sk_listener here is read-only despite there is no const here?

It is not const because we probably need to increment reference counts on i=
t.

But if you have 1000 SYN_RECV, they might share the same listener
socket, and we do not lock the listener socket,
this would not scale very well on servers with 10,000,000 tcp sockets :)

So using any listener-fields to store 'per-syn-recv' information is racy.

>
> Then, could you help to suggest the way please?
> Beacuse for AccECN, here we need to set fail flag after retransmitting SY=
N/ACK > 1 time.

Why not use state in req itself ? (Or tcp_rsk())

> And this was done within tcp_make_synack(), but now move to every place w=
here could retransmit SYN/ACK.
>
> Thanks.
> Chia-Yu

