Return-Path: <netdev+bounces-160154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F69A188B2
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FAB188AD11
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0638E632;
	Wed, 22 Jan 2025 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyxs59yx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C023DE;
	Wed, 22 Jan 2025 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737504286; cv=none; b=iYbtnbeTWrWlHYogcU3o6ytLh9DUHkb2ai7EWQh+E9f/9pfy+tqa7P8cCIDr1mTY4iXbpRy2GZmgjhczC4j2X/f3NAwN6G8ECyPf3gOpL66NVaZ6VHB4cn1R7HFyswADBWgW9zYJnDvqxGQ1v2MBblI0EolZkc43AAv+pAym6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737504286; c=relaxed/simple;
	bh=sS7W1r38bSAKHNGmPTGrzuSb09alKoZDQItUT0Rrx8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clFGN25mC3ckoD5g6y7dk5Yk/TbMFj/vT+8rcYtpD4FPfTgPwwkzd1R+L0A4HEUsbKFzMyZQXbEG6APFuzYTTFJSs/5lhwEL5V+5gqZCo8mGjFE6d95Nf/8lVZY0QMdMXCanKT6P6fbG0gHcDSJw33952M3fh9JVaJVpHTQnrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyxs59yx; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce873818a3so61252805ab.1;
        Tue, 21 Jan 2025 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737504283; x=1738109083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ0M7szEs4O8dWOqEqFFctmAF6e3nJ6jBDrwUM+BNlM=;
        b=kyxs59yxXRYqCXur0YPvN2KPsWtX1vZuKn1QV3sk73PKrUmsdV1/+av7I9HlQTcaAT
         oW0u1qheOo6GkH6mfTJ5c2iCP3UX8Ol0wu1mVJAEcjiU6RT/b3xRZFtBBi59tzxyD2xn
         jjR3xobxl1iU1xB60cag9TzwOm6C0lgYFW1pjawNzSyeDRPz6Db2d4LRppaqQcPTD9zw
         NIxmB3S409C600NATpKvEW3X3irErEQI7rZD9OjangUqpSoRMWMjDoMoscEKXmu3vq7B
         oCn3Ow3cwOjqq+vQzSM91neilvL6mSQMBbkOPf2ZtBm6JPhyiUWX5zjjwsJVytIH+OgY
         nNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737504283; x=1738109083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ0M7szEs4O8dWOqEqFFctmAF6e3nJ6jBDrwUM+BNlM=;
        b=J9XKVS93Tqgk/erwBmsrpSQvSxNUHTzWzDMUlxRYy+dEw6rIE8jW5W/nVi48vAq0s0
         TVOka+AvSvSJRD/ae3Dgry6O/wm/cv333SDLV0NthCZzUZAqf9HNCNCFl5FJ1fl7Ifl6
         hfVHYYUHBC3ihn0FySo28tDMPG75sKqqwRPbHjT0Y7xJ27ausgR0AS0r9rV83El38l6Y
         ejs2M/txij0ZXRF+uzuvpNWD2qi2QSGGpTYmsETt3P8OL4bSVdOvyhs4rez82zccJkXJ
         bh18Dbga/c+GLAYQDKTvd8Mg5aKWxGRt86DSoq0kVhBE91ACPbr/7TC5pOdmZzk16ZBm
         6JZA==
X-Forwarded-Encrypted: i=1; AJvYcCVOisn2iN1tsjD9wOW3y6tXD8CV8CvQfuQEUDhvXrTfgmtCBG20u07ODWE5gaNBjUtqIN+FkjKW@vger.kernel.org, AJvYcCWtWRgHmGpsNTGk8DToEXFis0Ihl50CLVmTIYvRaOoX6PEb0mk1YWZ/eFV++VWEzfukH0+hh2HrXI5eNbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EKQZL56rl9mqYJcbtps4u2tkwV518M9/fhWVWNP1faWYL0Fe
	XEGyrRWklJjTUOqbPn8qerX23cMguIIIPepferKI5AObhskvZvOu837mZVwiqvTCtk3RjoiCkta
	EAS/2azvwbsLOS3mJ/6p40RGMaQc=
X-Gm-Gg: ASbGncun3ndGma6Dbe/zhIGunU01IXBpPlq5wN0AepvLYUyFZwztRhjdyauadL/69Wh
	2epfZ5Rxt3O3wo6OGiE66ISR2uJNLLCaVSLDJ+jGlSDI0bCNAAg==
X-Google-Smtp-Source: AGHT+IGbqcbriy0JRprLADETYDCZEx3dmYwvMALrTLur7P/oH7kU7ijVHdP5Y2G7AtWIQo0tWk0Q/w3fs4qrgQXAMII=
X-Received: by 2002:a05:6e02:2402:b0:3a7:e0c0:5f27 with SMTP id
 e9e14a558f8ab-3cf743df906mr191671395ab.2.1737504283408; Tue, 21 Jan 2025
 16:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121220821.24694-1-feng.li@ieee.org>
In-Reply-To: <20250121220821.24694-1-feng.li@ieee.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Jan 2025 08:04:07 +0800
X-Gm-Features: AbW1kvair9NBSZCWhCYRnp-leGRm0R6PnFBDawJGeuXLOF2ptWKJZgYCIjcWULc
Message-ID: <CAL+tcoBKEncxUjLVCSDtVv=g6fQVuSXtfm9mUR+DBfKbJFhYrQ@mail.gmail.com>
Subject: Re: [PATCH] TCP: SEARCH a new slow start algorithm to replace Hystart
 in TCP Cubic
To: Feng Li <funglee@gmail.com>
Cc: feng.li@viasat.com, jaewon.chung@viasat.com, claypool@wpi.edu, 
	mataeikachooei@wpi.edu, Feng Li <feng.li@ieee.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Feng,

On Wed, Jan 22, 2025 at 6:08=E2=80=AFAM Feng Li <funglee@gmail.com> wrote:
>
> This patch implements a new TCP slow start algorithm (SEARCH) for TCP
> Cubic congestion control algorithm.  An IETF draft
> (https://datatracker.ietf.org/doc/draft-chung-ccwg-search/detailed)
> with detailed description of SEARCH is under review.  Moreover,  a
> series of papers give more detailed implementation information of this
> new slow start algorithm.

Thanks for the work.

Please provide one or a few packetdrill tests to show how good the
numbers are, which could be helpful to other reviewers to conduct the
same test.

Besides, could you elaborate more major concepts of SEARCH in the
commit message in the next respin, so that people can grasp the key
point immediately?

>
> The patch mainly adds SEARCH as the default slow start algorithm for
> TCP Cubic.  Please review the inline comments in the patch for the
> details.
>
> In tcp_cubic.c: (the only file changed in this patch).
> - add SEARCH as a new slow start algorithm
>
> - add new module parameters to configure SEARCH, allow user to enable/
> disable SEARCH or Hystart during runtime.
>
> - add SEARCH related variables into struct bictcp, to save memory
> footprint,  SEARCH shares share the space with hystart variables within
> a union
> - add SEARCH related functions search_update_bins() and search_update().
>
> Signed-off-by: Feng Li <feng.li@ieee.org>
> ---
>  net/ipv4/tcp_cubic.c | 386 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 345 insertions(+), 41 deletions(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 76c23675ae50..57111641fdae 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -52,7 +52,6 @@ static int initial_ssthresh __read_mostly;
>  static int bic_scale __read_mostly =3D 41;
>  static int tcp_friendliness __read_mostly =3D 1;
>
> -static int hystart __read_mostly =3D 1;
>  static int hystart_detect __read_mostly =3D HYSTART_ACK_TRAIN | HYSTART_=
DELAY;
>  static int hystart_low_window __read_mostly =3D 16;
>  static int hystart_ack_delta_us __read_mostly =3D 2000;
> @@ -72,8 +71,6 @@ module_param(bic_scale, int, 0444);
>  MODULE_PARM_DESC(bic_scale, "scale (scaled by 1024) value for bic functi=
on (bic_scale/1024)");
>  module_param(tcp_friendliness, int, 0644);
>  MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
> -module_param(hystart, int, 0644);
> -MODULE_PARM_DESC(hystart, "turn on/off hybrid slow start algorithm");
>  module_param(hystart_detect, int, 0644);
>  MODULE_PARM_DESC(hystart_detect, "hybrid slow start detection mechanisms=
"
>                  " 1: packet-train 2: delay 3: both packet-train and dela=
y");
> @@ -82,6 +79,48 @@ MODULE_PARM_DESC(hystart_low_window, "lower bound cwnd=
 for hybrid slow start");
>  module_param(hystart_ack_delta_us, int, 0644);
>  MODULE_PARM_DESC(hystart_ack_delta_us, "spacing between ack's indicating=
 train (usecs)");
>
> +//////////////////////// SEARCH ////////////////////////

Please do not use this style of comments.

> +/*     enable SEARCH with command:
> + *             sudo sh -c "echo '1' > /sys/module/your_module_name/param=
eters/slow_start_mode"
> + *     enable HyStart with command:
> + *             sudo sh -c "echo '2' > /sys/module/cubic_with_search/para=
meters/slow_start_mode"
> + *     disable both SEARCH and HyStart with command:
> + *             sudo sh -c "echo '0' > /sys/module/cubic_with_search/para=
meters/slow_start_mode"
> + */
> +
> +#define MAX_US_INT 0xffff
> +#define SEARCH_BINS 10         /* Number of bins in a window */
> +#define SEARCH_EXTRA_BINS 15   /* Number of additional bins to cover dat=
a after shiftting by RTT */
> +#define SEARCH_TOTAL_BINS 25   /* Total number of bins containing essent=
ial bins to cover RTT
> +                                * shift
> +                                */
> +
> +/* Define an enum for the slow start mode */
> +enum {
> +       SS_LEGACY =3D 0,  /* No slow start algorithm is used */
> +       SS_SEARCH =3D 1,  /* Enable the SEARCH slow start algorithm */
> +       SS_HYSTART =3D 2  /* Enable the HyStart slow start algorithm */
> +};
> +
> +/* Set the default mode */
> +static int slow_start_mode __read_mostly =3D SS_SEARCH;

I don't think it is robust enough right now for all kinds of flows and
it still needs more time than we expect. So please don't set it as
default.

> +static int search_window_duration_factor __read_mostly =3D 35;
> +static int search_thresh __read_mostly =3D 35;
> +static int cwnd_rollback __read_mostly;
> +static int search_missed_bins_threshold =3D 2;
> +
> +// Module parameters used by SEARCH

As I mentioned above, this kind of comment should be advised.

> +module_param(slow_start_mode, int, 0644);
> +MODULE_PARM_DESC(slow_start_mode, "0: No Algorithm, 1: SEARCH, 2: HyStar=
t");
> +module_param(search_window_duration_factor, int, 0644);
> +MODULE_PARM_DESC(search_window_duration_factor, "Multiply with (initial =
RTT / 10) to set the window size");
> +module_param(search_thresh, int, 0644);
> +MODULE_PARM_DESC(search_thresh, "Threshold for exiting from slow start i=
n percentage");
> +module_param(cwnd_rollback, int, 0644);
> +MODULE_PARM_DESC(cwnd_rollback, "Decrease the cwnd to its value in 2 ini=
tial RTT ago");
> +module_param(search_missed_bins_threshold, int, 0644);
> +MODULE_PARM_DESC(search_missed_bins_threshold, "Minimum threshold of mis=
sed bins before resetting SEARCH");
> +
>  /* BIC TCP Parameters */
>  struct bictcp {
>         u32     cnt;            /* increase cwnd by 1 after ACKs */
> @@ -95,19 +134,47 @@ struct bictcp {
>         u32     epoch_start;    /* beginning of an epoch */
>         u32     ack_cnt;        /* number of acks */
>         u32     tcp_cwnd;       /* estimated tcp cwnd */
> -       u16     unused;
> -       u8      sample_cnt;     /* number of samples to decide curr_rtt *=
/
> -       u8      found;          /* the exit point is found? */
> -       u32     round_start;    /* beginning of each round */
> -       u32     end_seq;        /* end_seq of the round */
> -       u32     last_ack;       /* last time when the ACK spacing is clos=
e */
> -       u32     curr_rtt;       /* the minimum rtt of current round */
> +
> +       /* Union of HyStart and SEARCH variables */
> +       union {
> +               /* HyStart variables */
> +               struct {
> +                       u16     unused;
> +                       u8      sample_cnt;/* number of samples to decide=
 curr_rtt */
> +                       u8      found;          /* the exit point is foun=
d? */
> +                       u32     round_start;    /* beginning of each roun=
d */
> +                       u32     end_seq;        /* end_seq of the round *=
/
> +                       u32     last_ack;       /* last time when the ACK=
 spacing is close */
> +                       u32     curr_rtt;       /* the minimum rtt of cur=
rent round */
> +               } hystart;
> +
> +               /* SEARCH variables */
> +               struct {
> +                       u32     bin_duration_us;        /* duration of ea=
ch bin in microsecond */
> +                       s32     curr_idx;       /* total number of bins *=
/
> +                       u32     bin_end_us;     /* end time of the latest=
 bin in microsecond */
> +                       u16     bin[SEARCH_TOTAL_BINS]; /* array to keep =
bytes for bins */
> +                       u8      unused;
> +                       u8      scale_factor;   /* scale factor to fit th=
e value with bin size*/
> +               } search;
> +       };

When we change from one algo to another, especially one flow already
staying in the middle of slow start, the above union fields are
supposed to be clear/reset? Could it cause any potential problem?

>  };
>
> +static inline void bictcp_search_reset(struct bictcp *ca)
> +{
> +       memset(ca->search.bin, 0, sizeof(ca->search.bin));
> +       ca->search.bin_duration_us =3D 0;
> +       ca->search.curr_idx =3D -1;
> +       ca->search.bin_end_us =3D 0;
> +       ca->search.scale_factor =3D 0;
> +}
> +
>  static inline void bictcp_reset(struct bictcp *ca)
>  {
> -       memset(ca, 0, offsetof(struct bictcp, unused));
> -       ca->found =3D 0;
> +       memset(ca, 0, offsetof(struct bictcp, hystart.unused));
> +       if (slow_start_mode =3D=3D SS_HYSTART)
> +               ca->hystart.found =3D 0;
> +
>  }
>
>  static inline u32 bictcp_clock_us(const struct sock *sk)
> @@ -120,10 +187,10 @@ static inline void bictcp_hystart_reset(struct sock=
 *sk)
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         struct bictcp *ca =3D inet_csk_ca(sk);
>
> -       ca->round_start =3D ca->last_ack =3D bictcp_clock_us(sk);
> -       ca->end_seq =3D tp->snd_nxt;
> -       ca->curr_rtt =3D ~0U;
> -       ca->sample_cnt =3D 0;
> +       ca->hystart.round_start =3D ca->hystart.last_ack =3D bictcp_clock=
_us(sk);
> +       ca->hystart.end_seq =3D tp->snd_nxt;
> +       ca->hystart.curr_rtt =3D ~0U;
> +       ca->hystart.sample_cnt =3D 0;
>  }
>
>  __bpf_kfunc static void cubictcp_init(struct sock *sk)
> @@ -132,15 +199,17 @@ __bpf_kfunc static void cubictcp_init(struct sock *=
sk)
>
>         bictcp_reset(ca);
>
> -       if (hystart)
> +       if (slow_start_mode =3D=3D SS_HYSTART)
>                 bictcp_hystart_reset(sk);
>
> -       if (!hystart && initial_ssthresh)
> +       if (slow_start_mode !=3D SS_HYSTART && initial_ssthresh)
>                 tcp_sk(sk)->snd_ssthresh =3D initial_ssthresh;
>  }
>
>  __bpf_kfunc static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca=
_event event)
>  {
> +       struct bictcp *ca =3D inet_csk_ca(sk);
> +
>         if (event =3D=3D CA_EVENT_TX_START) {
>                 struct bictcp *ca =3D inet_csk_ca(sk);
>                 u32 now =3D tcp_jiffies32;
> @@ -158,6 +227,12 @@ __bpf_kfunc static void cubictcp_cwnd_event(struct s=
ock *sk, enum tcp_ca_event e
>                 }
>                 return;
>         }
> +       if (event =3D=3D CA_EVENT_CWND_RESTART) {
> +               if (slow_start_mode =3D=3D SS_SEARCH)
> +                       bictcp_search_reset(ca);
> +               return;

The above 'return' is redundant, right?

> +       }
> +       return;
>  }
>
>  /* calculate the cubic root of x using a table lookup followed by one
> @@ -330,6 +405,8 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct so=
ck *sk, u32 ack, u32 acked)
>                 return;
>
>         if (tcp_in_slow_start(tp)) {
> +               if (slow_start_mode =3D=3D SS_HYSTART && after(ack, ca->h=
ystart.end_seq))
> +                       bictcp_hystart_reset(sk);
>                 acked =3D tcp_slow_start(tp, acked);
>                 if (!acked)
>                         return;
> @@ -359,7 +436,11 @@ __bpf_kfunc static void cubictcp_state(struct sock *=
sk, u8 new_state)
>  {
>         if (new_state =3D=3D TCP_CA_Loss) {
>                 bictcp_reset(inet_csk_ca(sk));
> -               bictcp_hystart_reset(sk);
> +               if (slow_start_mode =3D=3D SS_SEARCH)
> +                       bictcp_search_reset(inet_csk_ca(sk));

I'm afraid that if someone at the same time sets slow_start_mode from
HYSTART to SEARCH, the flow will miss the reset process. This kind of
case needs to be handled carefully.

> +
> +               if (slow_start_mode =3D=3D SS_HYSTART)
> +                       bictcp_hystart_reset(sk);
>         }
>  }
>
> @@ -389,19 +470,15 @@ static void hystart_update(struct sock *sk, u32 del=
ay)
>         struct bictcp *ca =3D inet_csk_ca(sk);
>         u32 threshold;
>
> -       if (after(tp->snd_una, ca->end_seq))
> +       if (after(tp->snd_una, ca->hystart.end_seq))
>                 bictcp_hystart_reset(sk);
>
> -       /* hystart triggers when cwnd is larger than some threshold */
> -       if (tcp_snd_cwnd(tp) < hystart_low_window)
> -               return;
> -
>         if (hystart_detect & HYSTART_ACK_TRAIN) {
>                 u32 now =3D bictcp_clock_us(sk);
>
>                 /* first detection parameter - ack-train detection */
> -               if ((s32)(now - ca->last_ack) <=3D hystart_ack_delta_us) =
{
> -                       ca->last_ack =3D now;
> +               if ((s32)(now - ca->hystart.last_ack) <=3D hystart_ack_de=
lta_us) {
> +                       ca->hystart.last_ack =3D now;
>
>                         threshold =3D ca->delay_min + hystart_ack_delay(s=
k);
>
> @@ -413,31 +490,31 @@ static void hystart_update(struct sock *sk, u32 del=
ay)
>                         if (sk->sk_pacing_status =3D=3D SK_PACING_NONE)
>                                 threshold >>=3D 1;
>
> -                       if ((s32)(now - ca->round_start) > threshold) {
> -                               ca->found =3D 1;
> +                       if ((s32)(now - ca->hystart.round_start) > thresh=
old) {
> +                               ca->hystart.found =3D 1;
>                                 pr_debug("hystart_ack_train (%u > %u) del=
ay_min %u (+ ack_delay %u) cwnd %u\n",
> -                                        now - ca->round_start, threshold=
,
> -                                        ca->delay_min, hystart_ack_delay=
(sk), tcp_snd_cwnd(tp));
> +                                        now - ca->hystart.round_start, t=
hreshold,
> +                                        ca->delay_min, hystart_ack_delay=
(sk), tp->snd_cwnd);
>                                 NET_INC_STATS(sock_net(sk),
>                                               LINUX_MIB_TCPHYSTARTTRAINDE=
TECT);
>                                 NET_ADD_STATS(sock_net(sk),
>                                               LINUX_MIB_TCPHYSTARTTRAINCW=
ND,
>                                               tcp_snd_cwnd(tp));
> -                               tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
> +                               tp->snd_ssthresh =3D tp->snd_cwnd;
>                         }
>                 }
>         }
>
>         if (hystart_detect & HYSTART_DELAY) {
>                 /* obtain the minimum delay of more than sampling packets=
 */
> -               if (ca->curr_rtt > delay)
> -                       ca->curr_rtt =3D delay;
> -               if (ca->sample_cnt < HYSTART_MIN_SAMPLES) {
> -                       ca->sample_cnt++;
> +               if (ca->hystart.curr_rtt > delay)
> +                       ca->hystart.curr_rtt =3D delay;
> +               if (ca->hystart.sample_cnt < HYSTART_MIN_SAMPLES) {
> +                       ca->hystart.sample_cnt++;
>                 } else {
> -                       if (ca->curr_rtt > ca->delay_min +
> +                       if (ca->hystart.curr_rtt > ca->delay_min +
>                             HYSTART_DELAY_THRESH(ca->delay_min >> 3)) {
> -                               ca->found =3D 1;
> +                               ca->hystart.found =3D 1;
>                                 NET_INC_STATS(sock_net(sk),
>                                               LINUX_MIB_TCPHYSTARTDELAYDE=
TECT);
>                                 NET_ADD_STATS(sock_net(sk),
> @@ -449,6 +526,226 @@ static void hystart_update(struct sock *sk, u32 del=
ay)
>         }
>  }
>
> +/* Scale bin value to fit bin size, rescale previous bins.
> + * Return amount scaled.
> + */
> +static inline u8 search_bit_shifting(struct sock *sk, u64 bin_value)
> +{
> +       struct bictcp *ca =3D inet_csk_ca(sk);
> +       u8 num_shift =3D 0;
> +       u32 i =3D 0;
> +
> +       /* Adjust bin_value if it's greater than MAX_BIN_VALUE */
> +       while (bin_value > MAX_US_INT) {
> +               num_shift +=3D 1;
> +               bin_value >>=3D 1;  /* divide bin_value by 2 */
> +       }
> +
> +       /* Adjust all previous bins according to the new num_shift */
> +       for (i =3D 0; i < SEARCH_TOTAL_BINS; i++)
> +               ca->search.bin[i] >>=3D num_shift;
> +
> +       /* Update the scale factor */
> +       ca->search.scale_factor +=3D num_shift;
> +
> +       return num_shift;
> +}
> +
> +/* Initialize bin */
> +static void search_init_bins(struct sock *sk, u32 now_us, u32 rtt_us)
> +{
> +       struct bictcp *ca =3D inet_csk_ca(sk);
> +       struct tcp_sock *tp =3D tcp_sk(sk);
> +       u8 amount_scaled =3D 0;
> +       u64 bin_value =3D 0;
> +
> +       ca->search.bin_duration_us =3D (rtt_us * search_window_duration_f=
actor) / (SEARCH_BINS * 10);
> +       ca->search.bin_end_us =3D now_us + ca->search.bin_duration_us;
> +       ca->search.curr_idx =3D 0;
> +       bin_value =3D tp->bytes_acked;
> +       if (bin_value > MAX_US_INT) {
> +               amount_scaled =3D search_bit_shifting(sk, bin_value);
> +               bin_value >>=3D amount_scaled;
> +       }
> +       ca->search.bin[0] =3D bin_value;
> +}
> +
> +/* Update bins */
> +static void search_update_bins(struct sock *sk, u32 now_us, u32 rtt_us)
> +{
> +       struct bictcp *ca =3D inet_csk_ca(sk);
> +       struct tcp_sock *tp =3D tcp_sk(sk);
> +       u32 passed_bins =3D 0;
> +       u32 i =3D 0;
> +       u64 bin_value =3D 0;
> +       u8 amount_scaled =3D 0;
> +
> +       /* If passed_bins greater than 1, it means we have some missed bi=
ns */
> +       passed_bins =3D ((now_us - ca->search.bin_end_us) / ca->search.bi=
n_duration_us) + 1;
> +
> +       /* If we passed more than search_missed_bins_threshold bins, need=
 to reset
> +        * SEARCH, and initialize bins
> +        */
> +       if (passed_bins > search_missed_bins_threshold) {
> +               bictcp_search_reset(ca);
> +               search_init_bins(sk, now_us, rtt_us);
> +               return;
> +       }
> +
> +       for (i =3D ca->search.curr_idx + 1; i < ca->search.curr_idx + pas=
sed_bins; i++)
> +               ca->search.bin[i % SEARCH_TOTAL_BINS] =3D
> +                       ca->search.bin[ca->search.curr_idx % SEARCH_TOTAL=
_BINS];
> +
> +       ca->search.bin_end_us +=3D passed_bins * ca->search.bin_duration_=
us;
> +       ca->search.curr_idx +=3D passed_bins;
> +
> +       /* Calculate bin_value by dividing bytes_acked by 2^scale_factor =
*/
> +       bin_value =3D tp->bytes_acked >> ca->search.scale_factor;
> +
> +       if (bin_value > MAX_US_INT) {
> +               amount_scaled  =3D search_bit_shifting(sk, bin_value);
> +               bin_value >>=3D amount_scaled;
> +       }
> +
> +       /* Assign the bin_value to the current bin */
> +       ca->search.bin[ca->search.curr_idx % SEARCH_TOTAL_BINS] =3D bin_v=
alue;
> +}
> +
> +/* Calculate delivered bytes for a window considering interpolation */
> +static inline u64 search_compute_delivered_window(struct sock *sk,

Please do not use inline in the .c file.

> +                                                 s32 left, s32 right, u3=
2 fraction)
> +{
> +       struct bictcp *ca =3D inet_csk_ca(sk);
> +       u64 delivered =3D 0;
> +
> +       delivered =3D ca->search.bin[(right - 1) % SEARCH_TOTAL_BINS]
> +                               - ca->search.bin[left % SEARCH_TOTAL_BINS=
];
> +
> +       /* If we are interpolating using the very first bin, the "previou=
s" bin value is 0. */
> +       if (left =3D=3D 0)
> +               delivered +=3D (ca->search.bin[left % SEARCH_TOTAL_BINS])=
 * fraction / 100;
> +       else
> +               delivered +=3D (ca->search.bin[left % SEARCH_TOTAL_BINS]
> +                               - ca->search.bin[(left - 1) % SEARCH_TOTA=
L_BINS]) * fraction / 100;
> +
> +       delivered +=3D (ca->search.bin[right % SEARCH_TOTAL_BINS]
> +                       - ca->search.bin[(right - 1) % SEARCH_TOTAL_BINS]=
)
> +                               * (100 - fraction) / 100;
> +
> +       return delivered;
> +}
> +
> +/* Handle slow start exit condition */
> +static void search_exit_slow_start(struct sock *sk, u32 now_us, u32 rtt_=
us)
> +{
> +       struct tcp_sock *tp =3D tcp_sk(sk);
> +       struct bictcp *ca =3D inet_csk_ca(sk);
> +       s32 cong_idx =3D 0;
> +       u32 initial_rtt =3D 0;
> +       u64 overshoot_bytes =3D 0;
> +       u32 overshoot_cwnd =3D 0;
> +
> +       /* If cwnd rollback is enabled, the code calculates the initial r=
ound-trip time (RTT)
> +        * and determines the congestion index (`cong_idx`) from which to=
 compute the overshoot.
> +        * The overshoot represents the excess bytes delivered beyond the=
 estimated target,
> +        * which is calculated over a window defined by the current and t=
he rollback indices.
> +        *
> +        * The rollback logic adjusts the congestion window (`snd_cwnd`) =
based on the overshoot:
> +        * 1. It first computes the overshoot congestion window (`oversho=
ot_cwnd`), derived by
> +        *    dividing the overshoot bytes by the maximum segment size (M=
SS).
> +        * 2. It reduces `snd_cwnd` by the calculated overshoot while ens=
uring it does not fall
> +        *    below the initial congestion window (`TCP_INIT_CWND`), whic=
h acts as a safety guard.
> +        * 3. If the overshoot exceeds the current congestion window, it =
resets `snd_cwnd` to the
> +        *    initial value, providing a safeguard to avoid a drastic dro=
p in case of miscalcula-
> +        *    tions  or unusual network conditions (e.g., TCP reset).
> +        *
> +        * After adjusting the congestion window, the slow start threshol=
d (`snd_ssthresh`) is set
> +        * to the updated congestion window to finalize the rollback.
> +        */
> +
> +       /* If cwnd rollback is enabled */
> +       if (cwnd_rollback) {
> +               initial_rtt =3D ca->search.bin_duration_us * SEARCH_BINS =
* 10
> +                               / search_window_duration_factor;
> +               cong_idx =3D ca->search.curr_idx - ((2 * initial_rtt) / c=
a->search.bin_duration_us);
> +
> +               /* Calculate the overshoot based on the delivered bytes b=
etween cong_idx and
> +                * the current index
> +                */
> +               overshoot_bytes =3D search_compute_delivered_window(sk, c=
ong_idx,
> +                                                                 ca->sea=
rch.curr_idx, 0);
> +
> +               /* Calculate the rollback congestion window based on over=
shoot divided by MSS */
> +               overshoot_cwnd =3D overshoot_bytes / tp->mss_cache;
> +
> +               /* Reduce the current congestion window (cwnd) with a saf=
ety guard:
> +                * It doesn't drop below the initial cwnd (TCP_INIT_CWND)=
 or is not
> +                * larger than the current cwnd (e.g., In the case of a T=
CP reset)
> +                */
> +               if (overshoot_cwnd < tp->snd_cwnd)
> +                       tp->snd_cwnd =3D max(tp->snd_cwnd - overshoot_cwn=
d, (u32)TCP_INIT_CWND);
> +               else
> +                       tp->snd_cwnd =3D TCP_INIT_CWND;
> +       }
> +
> +       tp->snd_ssthresh =3D tp->snd_cwnd;
> +
> +       /*  If TCP re-enters slow start, the missed_bin threshold will be
> +        *   exceeded upon a bin update, and SEARCH will reset automatica=
lly.
> +        */
> +}
> +
> +//////////////////////// SEARCH ////////////////////////
> +static void search_update(struct sock *sk, u32 rtt_us)
> +{
> +       struct bictcp *ca =3D inet_csk_ca(sk);
> +
> +       s32 prev_idx =3D 0;
> +       u64 curr_delv_bytes =3D 0, prev_delv_bytes =3D 0;
> +       s32 norm_diff =3D 0;
> +       u32 now_us =3D bictcp_clock_us(sk);
> +       u32 fraction =3D 0;
> +
> +       /* by receiving the first ack packet, initialize bin duration and=
 bin end time */
> +       if (ca->search.bin_duration_us =3D=3D 0) {
> +               search_init_bins(sk, now_us, rtt_us);
> +               return;
> +       }
> +
> +       if (now_us < ca->search.bin_end_us)
> +               return;
> +
> +       /* reach or pass the bin boundary, update bins */
> +       search_update_bins(sk, now_us, rtt_us);
> +
> +       /* check if there is enough bins after shift for computing previo=
us window */
> +       prev_idx =3D ca->search.curr_idx - (rtt_us / ca->search.bin_durat=
ion_us);
> +
> +       if (prev_idx >=3D SEARCH_BINS && (ca->search.curr_idx - prev_idx)=
 < SEARCH_EXTRA_BINS - 1) {
> +               /* Calculate delivered bytes for the current and previous=
 windows */
> +
> +               curr_delv_bytes =3D search_compute_delivered_window(sk,
> +                                                                 ca->sea=
rch.curr_idx - SEARCH_BINS,
> +                                                                 ca->sea=
rch.curr_idx, 0);
> +
> +               fraction =3D ((rtt_us % ca->search.bin_duration_us) * 100=
 /
> +                               ca->search.bin_duration_us);
> +
> +               prev_delv_bytes =3D search_compute_delivered_window(sk, p=
rev_idx - SEARCH_BINS,
> +                                                                 prev_id=
x, fraction);
> +
> +               if (prev_delv_bytes > 0) {
> +                       norm_diff =3D ((prev_delv_bytes << 1) - curr_delv=
_bytes)
> +                                       * 100 / (prev_delv_bytes << 1);
> +
> +                       /* check for exit condition */
> +                       if ((2 * prev_delv_bytes) >=3D curr_delv_bytes &&=
 norm_diff >=3D search_thresh)

Could you also add MIB counters here like
LINUX_MIB_TCPHYSTARTTRAINCWND? I recommended a separate patch (like
patch [2/2]) to implement that to keep this patch simple and small.

> +                               search_exit_slow_start(sk, now_us, rtt_us=
);
> +               }
> +       }
> +}
> +
> +//////////////////////////////////////////////////////////////

Same here.

>  __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack=
_sample *sample)
>  {
>         const struct tcp_sock *tp =3D tcp_sk(sk);
> @@ -471,8 +768,15 @@ __bpf_kfunc static void cubictcp_acked(struct sock *=
sk, const struct ack_sample
>         if (ca->delay_min =3D=3D 0 || ca->delay_min > delay)
>                 ca->delay_min =3D delay;
>
> -       if (!ca->found && tcp_in_slow_start(tp) && hystart)
> -               hystart_update(sk, delay);
> +       //////////////////////// SEARCH ////////////////////////

Here.

> +       if (tcp_in_slow_start(tp)) {
> +               if (slow_start_mode =3D=3D SS_SEARCH) {
> +                       /* implement search algorithm */
> +                       search_update(sk, delay);
> +               } else if (slow_start_mode =3D=3D SS_HYSTART && !ca->hyst=
art.found &&
> +                          tp->snd_cwnd >=3D hystart_low_window)
> +                       hystart_update(sk, delay);
> +       }
>  }
>
>  static struct tcp_congestion_ops cubictcp __read_mostly =3D {
> @@ -551,5 +855,5 @@ module_exit(cubictcp_unregister);
>
>  MODULE_AUTHOR("Sangtae Ha, Stephen Hemminger");
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("CUBIC TCP");
> -MODULE_VERSION("2.3");
> +MODULE_DESCRIPTION("CUBIC TCP w/ SEARCH");
> +MODULE_VERSION("3.0");
> --
> 2.47.1
>
>

