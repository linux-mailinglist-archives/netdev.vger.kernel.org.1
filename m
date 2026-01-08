Return-Path: <netdev+bounces-248282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7CAD06799
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 698B530245D9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFAB3382C3;
	Thu,  8 Jan 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EazdywGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D543328E2
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912617; cv=pass; b=JQdfxMMGhEhspg5h8WZUQ7Gz8GSBFGBBl8QoCuvxDwezp4AohuesIA7ZJTi9bJ0XQUDlX4AtxkMdOE92iODFmvDsUzge7ClxeErF4hSBIWAWVABOWVQSeHUXbIDuA/m6POI/hir5YIW6eNSMn2X3Zi8BQU7f9r6V6/SqZEYlTf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912617; c=relaxed/simple;
	bh=0Kg9b2/WsUIMEqmGuRHA5a4yLHhV5XKlV8sTuaMp9aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYe3CyONpoBf95HXbUKTMzf2/5xUIOtKdZ+DQth7WXwpvisXqxTJNCOCWqLtwT7nM3RZ55CbfeSJ0/xQOHfqhZ172r410yFngesAZ/RyTbXNxz3yV6n0pULDB1mxIUv3UWkB7t90L0iRxvtZur8EyQGJTQ+2oeLF/GH2cvk7Rfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EazdywGP; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4edb8d6e98aso182031cf.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 14:50:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912613; cv=none;
        d=google.com; s=arc-20240605;
        b=TxQvRf96ypXOfyHsmop7MxX0ctlIHQ9peOyPpp6wtiaSKMt7yJl03SFGhGcdFa0TSY
         TW/XTG9y3la/fSuP3jD6ztpah3oQJHmbQToWpZnTFqti/LZYTYirHGlRcHZ7t5RCWzz7
         TMppD6eBVgBjOU8yZu4dc01+Im7BraCBgFh28NHlp5GiAHVwjk2bfbzEKtwsKoB+Fcq8
         Jce6O5x0D624utOW7idgFOAtM8r9Y8OD/aTtXBj9UsnSR04JEzARJLhuh4mGRFq1Gons
         vtGyUrS5/nc6REgwHxCnhGIxSYf9zf4ywJlfsRXiQKhs6xntkRp6EWDM+wu0ci/4lAfG
         2Q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        fh=wXKSBxmT0pggzxR+rc0Ry76rLrbgdNT9fvUrw1TBdNI=;
        b=C58pQwrB6oOW8ha1aGp2UQjA4ySAQ50iNJLM/+PjrpS31+DdJYiFyJmILCqzR0neWc
         Rp5JX2rxj1Ap/h5AUcDFYHUBWkaLdzsI6CJV1ShdUDpZ0g6n3wiabSiefgAEFz/vKxt7
         RcpVA1WD0viBXMkl3HuwOUXEh8E2mKExcZNswwlR+tAq/MTR1+C1TcuW0i94idfMfj9M
         hatNzI/n2Gx5EwTwjzJYSN2nItvViEGXBnTC9Nmwcg1ZDrEv/J2yOL815+6fjyV5cKUN
         Mf3cPVpu4IgxHzI729Eah0o8ifuZJtfy6Yyw8hTvuWPwzEy6bvQ4vRr9GeSuhi/cnhv/
         NGmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912613; x=1768517413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        b=EazdywGPZDCXH3Fx5TCKx8lRPKR1YFKi2rVdJxp5TFEc9FPXgCHy4+KFLFNwGHIJJs
         MgHNdzGU30XBZ1gHL6jcB8RAcVWXfiGdoYbJDPT/CqaP2NI/yiTrIV1SNx0tyaZO4YXV
         zvkYL3UjcM9Z9Qf10f2eJdWOWTVNoySi2LyTw7UCfjNZxlGwaKLj4LgUzShVswoDMInM
         iDMUOmfSYe5ThtQoc6lXI5oOjrmKRbLm67kAwNWAZMg1esDPV1Al+Q0DnAb5EOEt7B1Z
         n2z9uIEFnyRVShloZtvQXCgoTvhZt3foz20FPgvtnC4XkJyMcEA6USyg1aQv2WE8QqnS
         bLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912613; x=1768517413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        b=drhN+ZDo0hwgtVzyq+Ph0uESiUltP+BKAqtX9CcUQardjh71/lNoirgbr7kMJ8Tnog
         Wvhz4v7eNLCMpltZ09XH61BN0WN+BfrnPR672524rrn0WEAJlYsZNstDHGyujNYBOagz
         1VPzhciBC4DO4QvO8LGar1ghbLLRM6GtVP1yFxoJ+KyTqCH4wEdaF5ID/kf9e7/ycwZM
         yRg5c6GuT48FaigkQdeFi6FBVvHABXGdEEqCL8Uf1nSLiqKUPU0wwFdEF81eXcKWKzKK
         ZRXDMOeAszjX+RpiTtDYAeYmRKnFMJmmpq1Oqk1NYdIoTXnX/l+4uUhqhGX9d7Uzi8ZD
         0opQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq1sezDYmaNjZKBLBxeGdhmCw1y9GbG53FuBP++75ikLPfw4YHsXxvQAfHYudb0KepMPst+BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uZgdAI3F8aQ3n/+dWXIWi+KU8WWbZUSPDuxNb4I5s+I5Fgar
	ycCAX7Fzp84lSZazJPr5K6MsVoWi7I/BhpU6mGCCdhXp5yvvHdSY3iUR2cYbN7PC0um1zje4B1f
	MGUMfhZMrUGWuXuLkj2p07Emttm2xrjchLCsrUI7L
X-Gm-Gg: AY/fxX63NowTohhCpbqrRKDGFYTm0k1MILzljRhFFUeyenWEFQVLXHrBMFWiF1CgKEy
	wY3Fgb0pgJ7aOJ8mJjK5YQYxW1WfqWCJ8CvmFhqBYS8CctF6/8f+/NggXiVL3Xakkk2oGzqlxui
	JxD0S5Zlyog6THdK7trABwwI7crBtUsGMGduFHUAdKk1GpfabRK1EStpIjFZulrmx9PrDdJcEM0
	y8QiugtTLpDOo5Ym2dHmC1QBGPur98QYM+Zc0pPGeWnG1zqqU1XeTAmZgEa42VlrGAolAJ3ifuv
	yb7EOUmwTr/eDA8e48c6pwqFDhF/UJevEpGnkc/SPhPYjMi6rprUUOV+DKM=
X-Received: by 2002:ac8:725a:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-4ffcbd0a84emr528911cf.3.1767912612694; Thu, 08 Jan 2026
 14:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com> <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
In-Reply-To: <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:49:55 -0500
X-Gm-Features: AQt7F2o6WroRcnLZsfsh5rQuai7Ltrdaj81MBXbeb_Nn4Vs-CAUHJkiKVn3RRPk
Message-ID: <CADVnQymHK0y_ALJ6obg60j+oUgjgpA8daaazin9hzO+-O6oRdA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:47=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.=
com> wrote:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > > cover several scenarios: Connection teardown, different ACK condition=
s,
> > > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > > retransmission/reorder/loss, AccECN option drop/loss, different
> > > handshake reflectors, data with marking, and different sysctl values.
> > >
> > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > ---

[apologies for the premature send due to accidental shift-of-focus...]

A third note:

(3) the patch title seems to have a typo; it is currently:
  selftests/net: Add packetdrill packetdrill cases

I would suggest something like:
  selftests/net: packetdrill: add TCP Accurate ECN cases

Thanks!
neal

