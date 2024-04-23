Return-Path: <netdev+bounces-90520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E178AE58F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E636D1F21E41
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06893136E38;
	Tue, 23 Apr 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6+pdu2i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C01369A8;
	Tue, 23 Apr 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873825; cv=none; b=sZUGXkcSv0o1gRmvIujObykXIej6UqYb8Ui57wl94ZMtvFRJMnwap1r3SXXYwYjCHUFcgKArqGfj9JTyA6QJSnyMxFLpR4dexicwbeX711ziLHgGf3swcNUj0QTDHGhD2hr6NnVghMSAOuAYFV87zGHIaFSnybZJ/kpXKO2akk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873825; c=relaxed/simple;
	bh=lVQZ5Rcf8gZ4XnRnWLlUduBtlydqs8gWc4eGtC4r3WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV1trZA3V2mMGxnwxCQOR03r1Y6yvWg8GcdhXtKenEdjeAACOJ7TB6UZwqC5D2QPkuhLVzQOVg7zv5XPtYkNhJmqtJfEz+tnGp1UR1qub2tGf7yySa+mZoIrNrMW1IBCPPbIC54bPj6iLddcAt/dkcL+pg6kiDwjFA+jkHKe9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6+pdu2i; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51b2f105829so2926786e87.3;
        Tue, 23 Apr 2024 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713873822; x=1714478622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/w20ZiELlVwKA6zWZGpUJTiub65abyXy03YW90UiWI=;
        b=P6+pdu2i3nSGBzp5pdVffyUNQXQMC69UB2R5Fgg2mUC61mNpI3im5NO1xuvgaa1bg8
         eEBFEohmgys+uP31wJnO84rt50e6eIlpgQYHVpsUWKfvDNphTG8vniMtAajT/8NaCVNU
         1C90RfalUWj8x5+3dQTfsX4SWCGPcSLf7zGylodhxKt26pBqE9r8sDH8XGhg3IZmDJdI
         foD+TDx1/fhyQy6ykQPb9ehkwM6RWQzJxMbq4NkoGQBqH1fVxBcDUo2UCZs0tvAtHPE9
         WwPJoOFDHvSYHhQSRiJ3ZDrpFMIXP4NTDnyi90SA7UrdVKS6+bHpehJe4oLPvEoivS2y
         51SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873822; x=1714478622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/w20ZiELlVwKA6zWZGpUJTiub65abyXy03YW90UiWI=;
        b=U/38QkRVk/yMpZ3CFqgS1+Vrkj5B0CqBn9Iqc852YWf+2TawQvAFRUR2k1AphctD0E
         rE3nVy4wUj2r5ORPY9OlTa7WvAajjV3wLFu3F6Xij72O817MVzycqR0zwTPblH0m5TP2
         iNv/ZtwxvKaWNKmNZNOe81iOc29lhtxg2gmlcpQo/ZFZzD/YNJKvziZrbFLogPRULXSG
         3/XqeeqO9PNC981iVTEZQvhFuONJxEIbgiRexloukJzMg9i0pZ5+03XeheF+kRd6nVBD
         YyMpFsx678jBWSlEhgng44ASdyMNPYLjnHk8zkyjT3NzH+uaupszP9vRdtqjKnbazR6v
         uWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyiwgXlO8sLuwwoGSrk/xtv+zCIMZsSqnBgjbBl8OxM2ceg8FUkHyMLEz3yiyqdOfvgrDOetju3sInYkKuS6FRpWYKCdnyy3WzJGGqS6n+85PQCIhs4bfihRpk5kdBF+SOiBAJ7SF/inQH
X-Gm-Message-State: AOJu0YyLIoT+LwgmyORPofztp5tYTxuCmcps110MAhbz3cLT8W64xE2n
	ZcWcB48W+DfiI5UV7zWid1Ld2b/c5Aw50dkFvogWTJsAe2PuOGwOulW9ZMttI/Fmdu2ljbn2l8U
	rgSy2aqYnXdJc/4p99BbHuOukgGYA6rvf
X-Google-Smtp-Source: AGHT+IEZrTkUH+yVEO1ei3tcIdp8WjujcTNUGA8uqf4omiHLerj30JF8ox6xLYlHGf0dYgq7TisU5lV6hfxep/8zQ3s=
X-Received: by 2002:a05:6512:3daa:b0:51a:d74b:f122 with SMTP id
 k42-20020a0565123daa00b0051ad74bf122mr11860840lfv.59.1713873822043; Tue, 23
 Apr 2024 05:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com> <20240422182755.GD42092@kernel.org>
 <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
 <CAL+tcoDoZ5CYn-fdK5AWaMe36O10ihe2Rd89dDmjBxiBDQ37sA@mail.gmail.com> <20240423115725.GR42092@kernel.org>
In-Reply-To: <20240423115725.GR42092@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 20:03:05 +0800
Message-ID: <CAL+tcoBA28pH0tvCadO6rqMUUnpKtAnGnqmfnYQhdLOB=978Jg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:57=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Apr 23, 2024 at 10:17:31AM +0800, Jason Xing wrote:
> > On Tue, Apr 23, 2024 at 10:14=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, Apr 23, 2024 at 2:28=E2=80=AFAM Simon Horman <horms@kernel.or=
g> wrote:
> > > >
> > > > On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:
> > > >
> > > > ...
> > > >
> > > > > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > > >
> > > > ...
> > > >
> > > > > +/**
> > > > > + * There are three parts in order:
> > > > > + * 1) reset reason in MPTCP: only for MPTCP use
> > > > > + * 2) skb drop reason: relying on drop reasons for such as passi=
ve reset
> > > > > + * 3) independent reset reason: such as active reset reasons
> > > > > + */
> > > >
> > > > Hi Jason,
> > > >
> > > > A minor nit from my side.
> > > >
> > > > '/**' denotes the beginning of a Kernel doc,
> > > > but other than that, this comment is not a Kernel doc.
> > > >
> > > > FWIIW, I would suggest providing a proper Kernel doc for enum sk_rs=
t_reason.
> > > > But another option would be to simply make this a normal comment,
> > > > starting with "/* There are"
> > >
> > > Thanks Simon. I'm trying to use the kdoc way to make it right :)
> > >
> > > How about this one:
> > > /**
> > >  * enum sk_rst_reason - the reasons of socket reset
> > >  *
> > >  * The reason of skb drop, which is used in DCCP/TCP/MPTCP protocols.
> >
> > s/skb drop/sk reset/
> >
> > Sorry, I cannot withdraw my previous email in time.
> >
> > >  *
> > >  * There are three parts in order:
> > >  * 1) skb drop reasons: relying on drop reasons for such as passive
> > > reset
> > >  * 2) independent reset reasons: such as active reset reasons
> > >  * 3) reset reasons in MPTCP: only for MPTCP use
> > >  */
> > > ?
> > >
> > > I chose to mimic what enum skb_drop_reason does in the
> > > include/net/dropreason-core.h file.
> > >
> > > > +enum sk_rst_reason {
> > > > +       /**
> > > > +        * Copy from include/uapi/linux/mptcp.h.
> > > > +        * These reset fields will not be changed since they adhere=
 to
> > > > +        * RFC 8684. So do not touch them. I'm going to list each d=
efinition
> > > > +        * of them respectively.
> > > > +        */
> > >
> > > Thanks to you, I found another similar point where I smell something
> > > wrong as in the above code. I'm going to replace '/**' with '/*' sinc=
e
> > > it's only a comment, not a kdoc.
>
> Likewise, thanks Jason.
>
> I haven't had time to look at v8 properly,
> but I see that kernel-doc is happy with the changed
> you have made there as discussed above.
>

Thank you, Simon. I learned something new about the coding style.

Besides, some other nit problems have been spotted by Matt. I will fix
them if it's required to send a new version.

