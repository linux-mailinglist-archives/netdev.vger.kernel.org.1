Return-Path: <netdev+bounces-90456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66328AE334
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D5282B9D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8D63099;
	Tue, 23 Apr 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E18zvbdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B1101EE;
	Tue, 23 Apr 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869899; cv=none; b=V2jow/K/2wwPXMb4dG2+PjoPvAttghDItjY59pu8t8AFIKAR1VEGbuO3kBSMjYLoCd9tjKP/B99NhuKj8kpLW89gCWADU1BAcZXLKecO+fiWQsW0q4uivqt5LsruQZgtdFGKNc83P8UpEusfk8gNNLN0TrDR+cHHD8C6T5aAawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869899; c=relaxed/simple;
	bh=2G21bZdClIVP3XU1/Itr1EYmTi4TedzOxz7EQAhSp4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVtdPahqH1X6MVMyRCClgo6GArhtqKp+4OZgYOJ6cjQOvu39ecl1lteJnibCBDRN71O0PKqi7nUd4X+BgltF/v53GDoO7eITjjd/XUwojyCXO+EQte76M0q4asIiPEOn6/STF1UQwWSpJcM1e1VH82d95js0hEW9P0BiuRdCJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E18zvbdm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a55b3d57277so267670166b.2;
        Tue, 23 Apr 2024 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713869896; x=1714474696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQXXpU+rcfCcur2KrBjeq7ARSKhXge7jDGCsw/eRdqU=;
        b=E18zvbdmLtM4UDD0M+el+EKa2b0vd5GXi92C2+5rLvJehHP/W8RbralWAYlW+Hzar1
         hDE4ZHGGQwMXRE32IUedhGAbNki4avDfBPfGeGEgSIIk/oitM1UEbNBAL/1/BmPxd1fd
         fwPodU2emETPL2NRKBmoOJy87IAV+ouOMNuDmbAO/apscsjDGuR+ENVIBu3fIy6jNO3E
         1eqKhpvVYAYKxWpCIMcakvoXBd/TZtV3sAUfbvZ69AofiC7ONOgW3ymKPVaRAntxIRuL
         nGsfA7jVbj+yyaqlIC1d3/sLi8xw6jDHioM9CZ3K2MURMH3j4/zj75DSa4gaK94PX5Xq
         DfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869896; x=1714474696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQXXpU+rcfCcur2KrBjeq7ARSKhXge7jDGCsw/eRdqU=;
        b=SvGdQrRWeBAdJirsx8Ulk0s1fHm1quXHD8HeRVpO1ik6AvuriuB3DclNwpokI05Af/
         0OMUwxWcgxkNHmfv4QYnPXrEbutvEFmpnge91UeNHdPBgsl759Fx97j2OBDED9DhOSzX
         G7YjIWf2nQB2O0uIp+w34qa70Fx5KRe7U5W78linOPy45l9ZQtOp2ew39Ky4k3oIssZG
         oZ2oPKJwu9xklViW4Xt5ir/rBd4fUs1uztpjtkF4uFf72hOtR6eRotQDZvnheG0c/Hyx
         IItaNr2YR9mWGJ6G0tbUHiRD46+30tw55dWZ6qPBptgS5tROIv7+5qI2/XrkNO+c/ykD
         Mn5g==
X-Forwarded-Encrypted: i=1; AJvYcCWpgqT3dHHZA7SOe5RCx9N5XrklKnONkqSQEad4zdRtZrhdRfCXsBGXBzf4epKfSK407BMcESbLeS3+z33B3FZ2PgPXpgUJbZ7w65XWGyDNFfm75U49uaHR6EwKV5pa/HXXKOYa/Ozq2GZA
X-Gm-Message-State: AOJu0YzBF4jGmHsauu4lPO7JnvDGtaICWU/pQ81dAEpg8bFJCtgtk+ee
	ssDmBDmN4dImdtHPkJSgmEKf+unHCyF8/srU1IgPRdoubXx3PHC+g6Q+CX4axpFb/5Aa1xEdvv2
	Qy6GuF6UTzTteuG2OYtVyve+yZ2I=
X-Google-Smtp-Source: AGHT+IGqnRrG5NL5x1ld5kYbE1cCFWXHJOxfyZH8DNDYP48sIoXCOmo4KQ1e4gx0sRivopZaJ6wKYVoz/vJ/OITKFH8=
X-Received: by 2002:a17:906:4f83:b0:a58:782c:eadb with SMTP id
 o3-20020a1709064f8300b00a58782ceadbmr1253991eju.31.1713869895551; Tue, 23 Apr
 2024 03:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
 <20240423072137.65168-6-kerneljasonxing@gmail.com> <4ce919ea-6110-4a84-8992-a72a9785c48b@kernel.org>
In-Reply-To: <4ce919ea-6110-4a84-8992-a72a9785c48b@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 18:57:38 +0800
Message-ID: <CAL+tcoC9kD8ZFkEJG2U=i6UrtxKzfQeFe5-q7pCfZ8SmM7arRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 5/7] mptcp: support rstreason for passive reset
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,

On Tue, Apr 23, 2024 at 6:02=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Jason,
>
> On 23/04/2024 09:21, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It relys on what reset options in the skb are as rfc8684 says. Reusing
>
> (if you have something else to fix, 'checkpatch.pl --codespell' reported
> a warning here: s/relys/relies/)

Thanks. Will fix it.

>
> > this logic can save us much energy. This patch replaces most of the pri=
or
> > NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/mptcp/protocol.h | 28 ++++++++++++++++++++++++++++
> >  net/mptcp/subflow.c  | 22 +++++++++++++++++-----
> >  2 files changed, 45 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index fdfa843e2d88..bbcb8c068aae 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -581,6 +581,34 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_conte=
xt *subflow)
> >       WRITE_ONCE(subflow->local_id, -1);
> >  }
> >
> > +/* Convert reset reasons in MPTCP to enum sk_rst_reason type */
> > +static inline enum sk_rst_reason
> > +sk_rst_convert_mptcp_reason(u32 reason)
> > +{
> > +     switch (reason) {
> > +     case MPTCP_RST_EUNSPEC:
> > +             return SK_RST_REASON_MPTCP_RST_EUNSPEC;
> > +     case MPTCP_RST_EMPTCP:
> > +             return SK_RST_REASON_MPTCP_RST_EMPTCP;
> > +     case MPTCP_RST_ERESOURCE:
> > +             return SK_RST_REASON_MPTCP_RST_ERESOURCE;
> > +     case MPTCP_RST_EPROHIBIT:
> > +             return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
> > +     case MPTCP_RST_EWQ2BIG:
> > +             return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
> > +     case MPTCP_RST_EBADPERF:
> > +             return SK_RST_REASON_MPTCP_RST_EBADPERF;
> > +     case MPTCP_RST_EMIDDLEBOX:
> > +             return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
> > +     default:
> > +             /**
>
> I guess here as well, it should be '/*' instead of '/**'. But I guess
> that's fine, this file is probably not scanned. Anyway, if you have to
> send a new version, please fix this as well.

Thanks for your help. I will.

>
> (Also, this helper might require '#include <net/rstreason.h>', but our
> CI is fine with it, it is also added in the next commit, and probably
> already included via include/net/request_sock.h. So I guess that's fine.)

Yes, If I need to submit the V9 patch, I will move it.

>
>
> Other than that, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for all the reviews :)

Thanks,
Jason

>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

