Return-Path: <netdev+bounces-45277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE37DBDC1
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B00B20BDE
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2B18C3B;
	Mon, 30 Oct 2023 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkiLgJkO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB818E04
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 16:24:39 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE51D9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:24:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so16010a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698683076; x=1699287876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47sn375hVOLfjdPqjUMe7dOzcxEppJhVtYv+fY0NC7c=;
        b=bkiLgJkOD+ZUPH7WnoNKa0E2I2xae9kJdkoFcAaHxexMLs1186J6/GUQiqXIx03T1C
         cDdPXlRSOSl1Et6Isuk1xSlTunoaRYIBOHZ4LlO48V7bSb8o/9moFfPGJ3+RIG55+BUj
         F3Vz13z6hFtNg72ZOj+emCKLp+Q9V1zzi3OBvN6/SviUphFrAFugwL0NPv9MuuV1vtyq
         epFxqodC+x0hr88+fr/iIcwoIAfkZ4OJkU1v5F9GaAfLQefWH5qZ88Hgjan7d6pLfIlx
         q1xwNonYgroJlS77CDGY0L7dncqE1jK54Msf475brZbrAN51qFdQi8a4n7JN0vuNR+MG
         Dcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698683076; x=1699287876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47sn375hVOLfjdPqjUMe7dOzcxEppJhVtYv+fY0NC7c=;
        b=tM16I2wnwfkm3OrvX4fMw8qVAG9i7rFAw2HSsXVDQnSRSRQ3QxqdxfsAGazumRld0z
         iDy3odlxaIunf9bJKRmyXGptI88LtYv4cwWjn/8xBGaZJQhmgndOs1DI+eMDfriabs+j
         htu3NORmFRWJ7W6Qj6d1wrjuO1fcyIntp/ZqZvfMsbIyzss67nfHUmlcgUnMsVcS5jNa
         xbcITQjKT2JxceosTjgRFospoCRpW3InPJpwKcHk55bYwd5iWbytnozEHkf42noohqmz
         Nxvs/MqNG9IYierGvPtjtvrXM4I0bzJTj7uKnDFDoDq32/a37/wo/IQL1Tbd8C6dcoui
         vNcg==
X-Gm-Message-State: AOJu0YyhnFVVwXUV69D/nG3TwkirdttmNVITJyR+rBzloz7LvRBSboft
	xLOYUQlPJnw/3Uz89Jafb1uyMQ1BJ9rvds3/i+Jdkw==
X-Google-Smtp-Source: AGHT+IGrXKMdli+cacqoxiuLEK7gZy+RUNBAXh2mBrV+tlY/AV/o7JUnKAU442dPQkj/qLo5ypyyQDdH1m4qBLAxRTo=
X-Received: by 2002:a50:9552:0:b0:540:9dbd:4b8 with SMTP id
 v18-20020a509552000000b005409dbd04b8mr141388eda.2.1698683075628; Mon, 30 Oct
 2023 09:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028144136.3462-1-bragathemanick0908@gmail.com>
 <CANn89iJyLWy6WEa_1p+jKpGBfq=h=TX=_7p_-_i4j6mHcMXbgA@mail.gmail.com>
 <e38353e7-ea99-434b-9700-151ab2de6f85@gmail.com> <CANn89iKPTdE+oAB30gp4koC7ddnga20R8H6V3qismvvEP80aqg@mail.gmail.com>
 <4fffeb15-52b1-4f2c-93bb-c3988ddfbf43@gmail.com>
In-Reply-To: <4fffeb15-52b1-4f2c-93bb-c3988ddfbf43@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Oct 2023 17:24:22 +0100
Message-ID: <CANn89iKsYu0_zWwsR97zyC7uuAKqEdJYC33-4eezBFVb3pj8Qw@mail.gmail.com>
Subject: Re: [PATCH net] dccp: check for ccid in ccid_hc_tx_send_packet
To: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 5:22=E2=80=AFPM Bragatheswaran Manickavel
<bragathemanick0908@gmail.com> wrote:
>
>
> On 30/10/23 21:19, Eric Dumazet wrote:
>
> On Mon, Oct 30, 2023 at 4:40=E2=80=AFPM Bragatheswaran Manickavel
> <bragathemanick0908@gmail.com> wrote:
>
> On 30/10/23 14:29, Eric Dumazet wrote:
>
> On Sat, Oct 28, 2023 at 4:41=E2=80=AFPM Bragatheswaran Manickavel
> <bragathemanick0908@gmail.com> wrote:
>
> ccid_hc_tx_send_packet might be called with a NULL ccid pointer
> leading to a NULL pointer dereference
>
> Below mentioned commit has similarly changes
> commit 276bdb82dedb ("dccp: check ccid before dereferencing")
>
> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc71bc336c5061153b502
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   net/dccp/ccid.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dccp/ccid.h b/net/dccp/ccid.h
> index 105f3734dadb..1015dc2b9392 100644
> --- a/net/dccp/ccid.h
> +++ b/net/dccp/ccid.h
> @@ -163,7 +163,7 @@ static inline int ccid_packet_dequeue_eval(const int =
return_code)
>   static inline int ccid_hc_tx_send_packet(struct ccid *ccid, struct sock=
 *sk,
>                                           struct sk_buff *skb)
>   {
> -       if (ccid->ccid_ops->ccid_hc_tx_send_packet !=3D NULL)
> +       if (ccid !=3D NULL && ccid->ccid_ops->ccid_hc_tx_send_packet !=3D=
 NULL)
>                  return ccid->ccid_ops->ccid_hc_tx_send_packet(sk, skb);
>          return CCID_PACKET_SEND_AT_ONCE;
>   }
> --
> 2.34.1
>
> If you are willing to fix dccp, I would make sure that some of
> lockless accesses to dccps_hc_tx_ccid
> are also double checked and fixed.
>
> do_dccp_getsockopt() and dccp_get_info()
>
> Hi Eric,
>
> In both do_dccp_getsockopt() and dccp_get_info(), dccps_hc_rx_ccid are
> checked properly before access.
>
> Not really, because another thread can change the value at the same time.
>
> Adding checks is not solving races.
>
> Understood. But when I see function similar to ccid_hc_tx_send_packet all=
 of
> them has ccid check and few of them have addressed same issue.
>
> dccp_get_info()
>         if (dp->dccps_hc_rx_ccid !=3D NULL)
>                 ccid_hc_rx_get_info(dp->dccps_hc_rx_ccid, sk, info);
>         if (dp->dccps_hc_tx_ccid !=3D NULL)
>                 ccid_hc_tx_get_info(dp->dccps_hc_tx_ccid, sk, info);
>

All I am saying is that these changes are not correct.

They are simply adding some 'checks' that are unsafe.

Compiler can absolutely fetch dp->dccps_hc_tx_ccid a second time,
and a NULL could be read this second time.

> do_dccp_getsockopt()
>     ccid_hc_rx_getsockopt
>     ccid_hc_tx_getsockopt
>     ccid_get_current_rx_ccid
>     ccid_get_current_tx_ccid   =3D=3D=3D> All of them have ccid check
>
> So, I went on with this changes.
> If you have another suggestion of fixing this issue please let me know. I=
 will take a look.

