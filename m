Return-Path: <netdev+bounces-245354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555ACCC107
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271843074CC6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0F23A9B0;
	Thu, 18 Dec 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPpzuEr0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600032E73E
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065049; cv=pass; b=oQn0G0cQygktRGbkol1f898OsyjcOcONoExzGLgwqwrXmXw0PWDMJ4BUW1H3qIUjUsM0APOWcfcRLG0+sX+S1pjHM2h5s+xuvS5TWT3wHNdHRDqEKG3UK3sOSNRtJK5umkJ017dDPIUaoWoqlmXNzHZBUTBc0g1fswSX5ZsBsPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065049; c=relaxed/simple;
	bh=0gX3hIRyqRGnUeZjxGQYtXpoUSWNhroO+uz8MkQiC5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri+ebE6LgWuXf6749o599rPCOO54J8tEFqgadlBb5CSv6zq1YTzClSLwhheAjzoQCZq9Zxrlkz8n8udnqDccD2vo8gxzEBqCmQQ4c0oJu51fYYQPNsnShNJZ4C8DQbAX+M3zASyCrAxokXvkCmKAbCXfi4LwMycZf4otgZMNw8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPpzuEr0; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edb8d6e98aso520271cf.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 05:37:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766065046; cv=none;
        d=google.com; s=arc-20240605;
        b=eKYS1AO5Izz1AZbo/K96bZw7zmdvD/fiBW0GQpEVs6kH5en6M69XPb9VVHyowaNN9L
         AnRlluFJSNtEd3Xq/pIKs/UpFb5/zm6U8YolofBnTkGtRWlRMIxXXZ2nBwLb4Pd8A69d
         pIIRi3RvyZ33/MT47sVappVfGGZIXDXy6FBgw/oiRbsXH/KdaaVZwQq8pYSJIXI5MkNa
         cp6FfiJLCYsiSG2dNjz18sc2sGcRUunEJkSDiXyAiXPyhmTiiWvoW8ndpmGgGkUCcD2W
         RuXFMTbDjNGcbV4aoPPIVT4y1mhmfR+Ppy8O5jSs+pOByK/9n7i/svqV5H63AlZrJO/+
         +Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1iyZvkmI59119iOKDBu/R/4bn825iy5Z6opKhg8ryOI=;
        fh=Zg+5euxzy0s7hwUtcmoW0dz9J6/I7EnOpUNURXsD+hQ=;
        b=AZ6/eyo/irmpK1DzgroTlxPV77+S/enFMSrlmGGn1X/dqwVzE0zDBQz+0ynhOSP4U+
         eHbW6QTpDwo9nBhQgme1TQZS5RAlA9KST4jBjY44BkFh/Ug2i2dE6vQH/elS9UxvOaXz
         WQHT5nUukDFYV4brLbW7KYQkq8Re01rQUl4qVTAv0rAIUIBUkMtRvl8LUVGPF4lmGMHr
         7WH3c5xN+ZIkCGtg/naV5RILfoM98yD/EehlOFy/cyqVWu0oqmymzn7V/zHNY7dsClDl
         1DiNOGmei4VviWU4DPm7fV9PklUIt3HYVjRHZKNyooCv/TzuI1yMLKLC9LThW5Pd7i1+
         eF/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766065046; x=1766669846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iyZvkmI59119iOKDBu/R/4bn825iy5Z6opKhg8ryOI=;
        b=CPpzuEr0PJWStH9jHfItNQtYwg2sq4yUJvCn3VQllF2lw1T0Ptdgn+o9fQTapPwbjb
         PX3nHYysXry4MdLj4sAxRO3uaFAUY12IVg07wxCLT8uSy6h0tMcQGwTvGkfG145NsjXy
         dk2LtnxbltusJPK3hwtJVCIXuUKojsXndj9Vcs65/ymSQeRdMPgRF0ykPOO9gViF0gow
         FtMON/fDitbbS1n8dX1z7y4NenBX+dzoSNlS2qB299VVOr1mQTKRcFPLToT1ejEpcriz
         o3VuWU5Hu6+ZgQ8aYkzrVlDsxZRqcR5iMxH2CLXYuOMtGxmEL9an41Wz8IRYURAshn4B
         KLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065046; x=1766669846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1iyZvkmI59119iOKDBu/R/4bn825iy5Z6opKhg8ryOI=;
        b=FD6V3G5eQA6mr8Cfh6Dhl6yxdXGhrYPKj46WA2i+q2579SrEnJx5rs4imxfPFCPq9K
         nt5AeywelGNiipn/2K0l6PMfjIp7M024R+rSJAEeSa+XYyZJ1WK3XAtmfaZrTG9gvMlD
         dTsWDUfM5h0I6WXV1Trbacjlxj+dxXQbVZAzKe163KlYnnwX06se3phuBpvkx4OncDJ/
         F6p1IWYUSpk9xJmDDlGbYhVh/GcrG6o6c/FpJSNGZQBieGISQZqbkuLcyCF+DIGmkdsH
         s8b1iJANjYfSkG6MDAOwITvrUF6gl9xyMpLdhAFhlTVDrH2g5o8u4XAAQVcqMovwMT1X
         FjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/NnotpH5zyy5HBYLabLLIKNcS77mo08pHVIreEFJL1zA1YgE33Cqg5l/LChJLPYon/Xbtm7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6EX52n7wZcsNcRtaHhPAjCwVe1Zm49DShxSVjvPt/19Pxx4v
	Vgw716APkeFkdcRvb66Q0sFGKABZkjBzA4rr5rYHg4sCpwAMF8j8iQEV9tsKolWJ3eIZ5sNmSxY
	Q1CFTu3y76rnANcHWtey1Ssg91dUXoN99dtydyuZwGIaLQd8Z6+by67aWhDs=
X-Gm-Gg: AY/fxX6Bj9ccXJXo6HnLSUMcbhOaMkMbuGZjNosmTCd9Jv0wxGBjrrL7EEKMnXa55we
	8yq8g7rdvUPAPN01jc6ZRS+nqyeui6TCG0aQRqbP2qTBMyOPDpJyQ/aqjcraWA2KyV0EKxtGcd7
	kSYtROihDXliac4YvnCB2ugFjEheg/y8MYoue+gsUzQMCYpYZQO/3RXMbZ5YlNWAibDw+VU9orL
	BCsLAKHDRxdIDVQK4wWC1XxdWoq3dQdy3Rh9H21vTQL1JeJm7w1mEOALNX8/DyNr9qzojtPQN4O
	Qn7v0C5KAmtGQZ4iKXujP5kSa8gHaEGCH1Hd+TKxL9rYnMF+J3o0Rj1ZDvua
X-Google-Smtp-Source: AGHT+IH0tsGGveO6QZZuuvuMJZ9MCqXbMS1ycifgN8/LJxAVopHuhPrV5bqshe6PF6+nYJu4KkoUVEyN66JNsNRCSBM=
X-Received: by 2002:ac8:7fd6:0:b0:4f1:a60e:bc33 with SMTP id
 d75a77b69052e-4f360d617b4mr6929501cf.2.1766065045436; Thu, 18 Dec 2025
 05:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218105819.63906-1-daniel.sedlak@cdn77.com>
In-Reply-To: <20251218105819.63906-1-daniel.sedlak@cdn77.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 18 Dec 2025 08:37:08 -0500
X-Gm-Features: AQt7F2pq5IyEB80yQ6en6R1VkA04VznEfiNn8CDc9sP_DD18B31lYmwc6ruc4I0
Message-ID: <CADVnQy=-UP9jJ5-bv=aRYL5fEtpjscDEAC1G=_cCM4gF10W8ew@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clarify tcp_congestion_ops functions comments
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:58=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn77.=
com> wrote:
>
> The optional/required hints in the tcp_congestion_ops are information
> for the user of this interface to signalize its importance when
> implementing these functions.
>
> However, cong_avoid comment incorrectly tells that it is required.
> For example the BBR does not implement this function, thus mark it as
> an optional.
>
> In addition, min_tso_segs has not had any comment optional/required
> hints. So mark it as optional since it is used only in BBR.
>
> Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
> ---
>  include/net/tcp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0deb5e9dd911..a94722e4de8c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1246,7 +1246,7 @@ struct tcp_congestion_ops {
>         /* return slow start threshold (required) */
>         u32 (*ssthresh)(struct sock *sk);
>
> -       /* do new cwnd calculation (required) */
> +       /* do new cwnd calculation (optional) */
>         void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);

Thanks for proposing a patch to update this incorrect comment!

I agree that some kind of update here is worthwhile, since indeed
cong_avoid is not strictly required.

However, IMHO "optional" does not quite capture all the important
information/constraints here. If we're going to update this comment,
which I agree is worthwhile, then I'd suggest that we have the
comments clarify that a CC module must implement either cong_avoid or
cong_control.

Perhaps we can move cong_avoid and cong_control to the top of the
module so that they are next to each other, and provide a single
comment to explain their relationship, and when to implement one vs
implementing the other.

Perhaps something like the following.

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 10706a1753e96..d35908bc977db 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1326,12 +1326,28 @@ struct rate_sample {
 struct tcp_congestion_ops {
 /* fast path fields are put first to fill one cache line */

+       /* A congestion control (CC) must provide one of either:
+        *
+        * (a) a cong_avoid function, if the CC wants to use the core TCP
+        *     stack's default functionality to implement a "classic"
+        *     (Reno/CUBIC-style) response to packet loss, RFC3168 ECN,
+        *     idle periods, pacing rate computations, etc.
+        *
+        * (b) a cong_control function, if the CC wants custom behavior and
+        *      complete control of all congestion control behaviors
+        */
+       /* (a) "classic" response: calculate new cwnd.
+        */
+       void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
+       /* (b) "custom" response: call when packets are delivered to update
+        * cwnd and pacing rate, after all the ca_state processing.
+        */
+       void (*cong_control)(struct sock *sk, u32 ack, int flag,
+                            const struct rate_sample *rs);
+
        /* return slow start threshold (required) */
        u32 (*ssthresh)(struct sock *sk);

-       /* do new cwnd calculation (required) */
-       void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
-
        /* call before changing ca_state (optional) */
        void (*set_state)(struct sock *sk, u8 new_state);

@@ -1347,12 +1363,6 @@ struct tcp_congestion_ops {
        /* pick target number of segments per TSO/GSO skb (optional): */
        u32 (*tso_segs)(struct sock *sk, unsigned int mss_now);

-       /* call when packets are delivered to update cwnd and pacing rate,
-        * after all the ca_state processing. (optional)
-        */
-       void (*cong_control)(struct sock *sk, u32 ack, int flag, const
struct rate_sample *rs);
-
-
        /* new value of cwnd after loss (required) */
        u32  (*undo_cwnd)(struct sock *sk);
        /* returns the multiplier used in tcp_sndbuf_expand (optional) */

How does that sound?

>
>         /* call before changing ca_state (optional) */
> @@ -1261,7 +1261,7 @@ struct tcp_congestion_ops {
>         /* hook for packet ack accounting (optional) */
>         void (*pkts_acked)(struct sock *sk, const struct ack_sample *samp=
le);
>
> -       /* override sysctl_tcp_min_tso_segs */
> +       /* override sysctl_tcp_min_tso_segs (optional) */

This part looks good to me as-is.

Thanks!
neal

