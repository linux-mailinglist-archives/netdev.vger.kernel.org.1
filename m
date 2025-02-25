Return-Path: <netdev+bounces-169439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE3A43EC3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CCD3A7EEC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749F7267F5F;
	Tue, 25 Feb 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=xpedite-tech.com header.i=@xpedite-tech.com header.b="gff+HtU6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2829CF0
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485095; cv=none; b=sHMVG/7FT7H0dKjBM8nCkl4jzr3BQa7MXZGyRm8vSWFjG27au2KXMimOHSSzXvV3dnxw/IMuc04QiMOjrSUngfcjgXVZkz0UrRW5KgRe1VY8cthO5I+lrd0oonnxypmIX/msICR88Qu7EwtXghOE0UHC64fcpbgMyVP98RltmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485095; c=relaxed/simple;
	bh=yE7H22V0uFiCtzVppDgh3WMuasTY8OzGkcgWsvhIhOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkS+2/JzjLuksOIJDbB7/7uTxGlOoEQsqBvgc1m7zd6rTGPN/xiSDkj0+hwwQgB6l3PdgmwjgyYkTRjM1J5ujIXQC68KP/lYSAHLNvhaUBtmChhW6QywzHXjwcDLxkmf31Donkv6rCQneeefzuxVaZ1CWRLk4naJDmHZuyo3VPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xpedite-tech.com; spf=pass smtp.mailfrom=xpedite-tech.com; dkim=temperror (0-bit key) header.d=xpedite-tech.com header.i=@xpedite-tech.com header.b=gff+HtU6; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xpedite-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xpedite-tech.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72726025fa5so1469249a34.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 04:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xpedite-tech.com; s=google; t=1740485092; x=1741089892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSfp0wqtDDyworITem6k3T9z2pfFqgSsCHRMw5eT8PE=;
        b=gff+HtU6fuXVRtr4npGqdQAYRZPTvpM8vu15HNwgiQiu7mq3MHAyq/S1nVDQI3Y0/G
         gQJFniExDFs38+gfdLB0Y4IefLJW4CbYXBhmiFPlX7n8XTor8Vo5LnHc8o3famx1K3aU
         z7MahuRppxS7MkOmxcxgKslUtNRC+XoiLl8Vjmr1MqjlL0k77a5yI0dOj9taZicA5KK+
         neTxRvuE71Jy+RvIpUuSENfATAjLNyEG2lKxIIrbp/1Iz8HTkoyfBCiMBqc0z+f0+fCv
         jYwxCQIOv4WI2qcRRSxiVXeJzFISc8K0NbXMCY0jPtOC2CY+as3PjZi2rUNfD8syigVN
         3Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485092; x=1741089892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSfp0wqtDDyworITem6k3T9z2pfFqgSsCHRMw5eT8PE=;
        b=LB5RrFdWS9Y86oMjHFy4tD8mR0NoOwrSObOhtg5eu+j1k1z8DtX+AccwRoaB/X9Kue
         e7WZDx/NhsF+BmgGu5dsFiEQMsg8Wdfrhg9/H4jGaFzpvPPxkE4UGOh0JBMp/vhQG/ro
         Skq+Fx/cGG0OZ30p1lUeVKWpUheYVpyJfc68FoElPaCOD6/rZnIESxyfp1RTRl5FjnPF
         PnqV/V51B6CwhxbSY4e5ImtrO/s2OwegaRUaFTE4vjFgyv+uE35c0+njPibfDHNTnyBH
         Kpx/CeLxHWkU26tK9uxgXVMUuSxN6zzh2c7vLI6LU7RwMPr4Whoaqd+7L3um/60N7+0L
         7VKA==
X-Forwarded-Encrypted: i=1; AJvYcCVAD+cP7blHjtI1orvsT1Mu5EQDM8/gpj4zM2p8ZIDUsgqmDQ+ataZtefID6c5fgo7mfjD1sKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYX5S/VeOahcpv2LarPrZNi3BlLBbmW3JloPY7u2bkyaXZOOo
	rrSgM3hhsq0xgocwycsFhVR/a8bAP4SFMzNlNfHcemIY/mIkzgE6VF7UVXrwT6HryOVqigOBeqa
	Z7GC+1UcfETS1lOyym9AMvhLNLPi3sVmPcp2KBg==
X-Gm-Gg: ASbGncuk7MdgPoOKpi5oXHZYGyhpsZF8C7KJ5nVmE7Vpy1TzN58HRrblsHgTNSFRq+h
	IKbABRBfvGdWAwPhXw8Fns7VhCy5je0OHUSDTSFHu769hirbj+C/gpq7/T5/t1HMGya9GNiC7sQ
	+Ia2Yc
X-Google-Smtp-Source: AGHT+IFxChJjsQmtkzVHbDEsQnJtoP2zQ4RwuNhq/gb8zO9vyDTiERJo6F2GgebR20h2a1YsTQFsY6jfVQR1EP1ys30=
X-Received: by 2002:a05:6830:65c2:b0:727:42cb:db25 with SMTP id
 46e09a7af769-7289d1840e1mr2276551a34.25.1740485092672; Tue, 25 Feb 2025
 04:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org> <20250224-net-mptcp-misc-fixes-v1-2-f550f636b435@kernel.org>
In-Reply-To: <20250224-net-mptcp-misc-fixes-v1-2-f550f636b435@kernel.org>
From: "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
Date: Tue, 25 Feb 2025 12:04:41 +0000
X-Gm-Features: AWEUYZks3-zpV9BgaLEsplR7ehMtt5Cm16964KCfO-pnDzVnFeXwC2kQ-zE55-c
Message-ID: <CAD501Os6sdNrc0PaD8Lnew1UO8nWRVd+0z=DgLEuUttus3aDQw@mail.gmail.com>
Subject: Re: [PATCH net 2/3] mptcp: reset when MPTCP opts are dropped after join
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Zenon van Deventer <zenon@xpedite-tech.com>, 
	dwayne Du Preez <dwayne.dupreez@xpedite-tech.com>, 
	Alexander Scholten <alexander.scholten@xpedite-tech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>

Thanks a ton!
Chester A.

On Mon, Feb 24, 2025 at 6:19=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Before this patch, if the checksum was not used, the subflow was only
> reset if map_data_len was !=3D 0. If there were no MPTCP options or an
> invalid mapping, map_data_len was not set to the data len, and then the
> subflow was not reset as it should have been, leaving the MPTCP
> connection in a wrong fallback mode.
>
> This map_data_len condition has been introduced to handle the reception
> of the infinite mapping. Instead, a new dedicated mapping error could
> have been returned and treated as a special case. However, the commit
> 31bf11de146c ("mptcp: introduce MAPPING_BAD_CSUM") has been introduced
> by Paolo Abeni soon after, and backported later on to stable. It better
> handle the csum case, and it means the exception for valid_csum_seen in
> subflow_can_fallback(), plus this one for the infinite mapping in
> subflow_check_data_avail(), are no longer needed.
>
> In other words, the code can be simplified there: a fallback should only
> be done if msk->allow_infinite_fallback is set. This boolean is set to
> false once MPTCP-specific operations acting on the whole MPTCP
> connection vs the initial path have been done, e.g. a second path has
> been created, or an MPTCP re-injection -- yes, possible even with a
> single subflow. The subflow_can_fallback() helper can then be dropped,
> and replaced by this single condition.
>
> This also makes the code clearer: a fallback should only be done if it
> is possible to do so.
>
> While at it, no need to set map_data_len to 0 in get_mapping_status()
> for the infinite mapping case: it will be set to skb->len just after, at
> the end of subflow_check_data_avail(), and not read in between.
>
> Fixes: f8d4bcacff3b ("mptcp: infinite mapping receiving")
> Cc: stable@vger.kernel.org
> Reported-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/subflow.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index dfcbef9c46246983d21c827d9551d4eb2c95430e..9f18217dddc865bc467a2c5c3=
4aa4bf23bf3ac75 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1142,7 +1142,6 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk,
>         if (data_len =3D=3D 0) {
>                 pr_debug("infinite mapping received\n");
>                 MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> -               subflow->map_data_len =3D 0;
>                 return MAPPING_INVALID;
>         }
>
> @@ -1286,18 +1285,6 @@ static void subflow_sched_work_if_closed(struct mp=
tcp_sock *msk, struct sock *ss
>                 mptcp_schedule_work(sk);
>  }
>
> -static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
> -{
> -       struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> -
> -       if (subflow->mp_join)
> -               return false;
> -       else if (READ_ONCE(msk->csum_enabled))
> -               return !subflow->valid_csum_seen;
> -       else
> -               return READ_ONCE(msk->allow_infinite_fallback);
> -}
> -
>  static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
>  {
>         struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> @@ -1393,7 +1380,7 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>                         return true;
>                 }
>
> -               if (!subflow_can_fallback(subflow) && subflow->map_data_l=
en) {
> +               if (!READ_ONCE(msk->allow_infinite_fallback)) {
>                         /* fatal protocol error, close the socket.
>                          * subflow_error_report() will introduce the appr=
opriate barriers
>                          */
>
> --
> 2.47.1
>

