Return-Path: <netdev+bounces-176241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F246A69779
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C104E3B1031
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A4C1D54D6;
	Wed, 19 Mar 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUxocVZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9361DF258;
	Wed, 19 Mar 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407731; cv=none; b=P6XsY/cPs7V6FYg+tHfiDmspOW2t5Wg9u8HexK5HDiiKAxMDgJLfm24O546vKrrGN6X/OKnXIoczOgapJ8VTqoxx1CW7d+7vtuhL0v/W/aTaJ/4T76dUOwXU3RFNUcb1rTpLEpIi6BkSszJPLLCpu+L4cac00dJf5aN6WW3GNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407731; c=relaxed/simple;
	bh=ksRh8wBx9XsllJHYgxtC9h4Xk7I3XeqcpTZX6FaSAeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiLNF048/cjSAEPCUuW2Y+2nGNPMW/IdrHjAMs8gkQwkUn7z/HNqhxj3NfMlYlTIHJm8b73hBpriWT7RkDF3V1uUEmFgUlBMdAN6eGxruDmuPtT1IB6zY/st66EUPAArpYMZbTS8h7p0mUwRAYEzEG55RYD38mpZwdP9QoXrJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUxocVZA; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d3805a551so3292129241.3;
        Wed, 19 Mar 2025 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742407728; x=1743012528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2e+VASJvhMSdxri9GWf3DzgLKmwPUKxIoKmVo7qpYU=;
        b=iUxocVZAaEc7u7zO3U6QNM5LawLTrdq9MQPw4Iz9KVh0QE13VTSy7hxcVkicSe6t8v
         kjSFJfNOd0T7PNn4rW+BgPB/V4zvy+EhXsvXDrQSL/8nEK8Jk7QCvuNJ5Gq+xndlnuQ5
         NzqFYgPjIiuFs0UHaLarIRIyK0AfH7zT+IMGaRI241McJDOHydy/IPBMGNzApZtyCMcn
         bUJYxXBJoqvQKJkszrCx48D1eEMGfb+2mt3LlWoVcp9yyPhZ0Cz6fmraEl5z4rVqsV0D
         fkP6vOuzZszbsLxz1O5HxXFiQtafjz/dp6mpKbGAhK2SqsOaM4jmgzAXUdtb+KkzUPdn
         aKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407728; x=1743012528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2e+VASJvhMSdxri9GWf3DzgLKmwPUKxIoKmVo7qpYU=;
        b=O3Xp4Pfj2HpJJ3W3utCOm0fBPY4sJZM3KlNBpFtJWKL/QDAxSmnb7pe1W5zJ+T4iD5
         S85ygn/1tBA+PERC2+rZz+3uuOGSLz0Kvt3LQzbnKve1yfaYrNz8FFO96iWrGmpM9Pot
         5o2RyOgENYXdwshT1UCgMF/UG2l8p1CLmMgKhOLjsnIc8xAi0GPbERs7z181E8oB37ao
         j8USFSuZK4KBqnqssLMGlZ0TtASMGpSz9SVmBLGsidWPpe3Rlteq4JbTyeUfw9uHrIKV
         5D+q+U4mn5ZlZTqPbpo7h1zzJF4fORoqE94P/ud754OA5+pGqXYv9vtHGdNprHJWRZTN
         BntQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVPSWgai2Z4yldKefGOH+LY7wsD2Gvqgj7ERWq43yij+Yn3+IJ+Xsc9OxOsgK92dOtlB7i@vger.kernel.org, AJvYcCUtM+IQxigWd5EenwTmWgGLQfENgzE6lOtKSddIO5G09uURUf4iagiyRNBOFSR0iasanjZ5jpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2yeJfLG8ho9/ARo6uEcCQcrdnpGLpdmwfQLRL7Wq+zt3OZXv
	lKcOQFSgG+q5YsyQiwf8LLSwJ8sjqR1pptX5OpaTDmPS51AUXuSgQgU3S7AHE+i8EGlRWAYHblG
	GNgutK3UAxSeCQkRuMwUVJWzu/lI=
X-Gm-Gg: ASbGncs8OLffM2V3SCP5pwGqUbt6AceMubWHVc7X/rcKcJVbdNsYLVSgHe0lim8v89r
	CPWk0FYtlerRN137qUgO25/4dLE4MpVlf/NqSdiX1Asaqd53XWtrG7OVvyK3dD6WwXf15o63IND
	z8nXa+w04NptUovYu9soGK8cJ0s7FlNm9KLXV5A3g=
X-Google-Smtp-Source: AGHT+IGGM1A5RhOvTuu0AdrRxkEnROVM7klP75DRND/6RxJ/msNvId9LsPUlAO52bSTHwwJxoxglagUFj8/mcfs6YII=
X-Received: by 2002:a05:6122:6142:b0:518:865e:d177 with SMTP id
 71dfb90a1353d-52589291044mr3030042e0c.9.1742407728320; Wed, 19 Mar 2025
 11:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-meticulous-succinct-mule-ddabc5@leitao>
 <CANn89iLRePLUiBe7LKYTUsnVAOs832Hk9oM8Fb_wnJubhAZnYA@mail.gmail.com>
 <20250319-sloppy-active-bonobo-f49d8e@leitao> <5e0527e8-c92e-4dfb-8dc7-afe909fb2f98@paulmck-laptop>
 <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>
In-Reply-To: <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 19 Mar 2025 11:08:35 -0700
X-Gm-Features: AQ5f1Jrq2PDQGCyCHQKcD4stIBbEhDXypryz1JKQj6Skn3GDIZXnBW7_5Um-J80
Message-ID: <CAM_iQpVe+dscK_6hRnTMc_6QjGiBHX0gtaDiwfxggD7tgccbsg@mail.gmail.com>
Subject: Re: tc: network egress frozen during qdisc update with debug kernel
To: Eric Dumazet <edumazet@google.com>
Cc: paulmck@kernel.org, Breno Leitao <leitao@debian.org>, kuba@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuniyu@amazon.com, rcu@vger.kernel.org, 
	kasan-dev@googlegroups.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
>
>
> On Wed, Mar 19, 2025 at 4:04=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:
>>
>> On Wed, Mar 19, 2025 at 07:56:40AM -0700, Breno Leitao wrote:
>> > On Wed, Mar 19, 2025 at 03:41:37PM +0100, Eric Dumazet wrote:
>> > > On Wed, Mar 19, 2025 at 2:09=E2=80=AFPM Breno Leitao <leitao@debian.=
org> wrote:
>> > >
>> > > > Hello,
>> > > >
>> > > > I am experiencing an issue with upstream kernel when compiled with=
 debug
>> > > > capabilities. They are CONFIG_DEBUG_NET, CONFIG_KASAN, and
>> > > > CONFIG_LOCKDEP plus a few others. You can find the full configurat=
ion at
>> > > > ....
>> > > >
>> > > > Basically when running a `tc replace`, it takes 13-20 seconds to f=
inish:
>> > > >
>> > > >         # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1=
234: mq
>> > > >         real    0m13.195s
>> > > >         user    0m0.001s
>> > > >         sys     0m2.746s
>> > > >
>> > > > While this is running, the machine loses network access completely=
. The
>> > > > machine's network becomes inaccessible for 13 seconds above, which=
 is far
>> > > > from
>> > > > ideal.
>> > > >
>> > > > Upon investigation, I found that the host is getting stuck in the =
following
>> > > > call path:
>> > > >
>> > > >         __qdisc_destroy
>> > > >         mq_attach
>> > > >         qdisc_graft
>> > > >         tc_modify_qdisc
>> > > >         rtnetlink_rcv_msg
>> > > >         netlink_rcv_skb
>> > > >         netlink_unicast
>> > > >         netlink_sendmsg
>> > > >
>> > > > The big offender here is rtnetlink_rcv_msg(), which is called with
>> > > > rtnl_lock
>> > > > in the follow path:
>> > > >
>> > > >         static int tc_modify_qdisc() {
>> > > >                 ...
>> > > >                 netdev_lock_ops(dev);
>> > > >                 err =3D __tc_modify_qdisc(skb, n, extack, dev, tca=
, tcm,
>> > > > &replay);
>> > > >                 netdev_unlock_ops(dev);
>> > > >                 ...
>> > > >         }
>> > > >
>> > > > So, the rtnl_lock is held for 13 seconds in the case above. I also
>> > > > traced that __qdisc_destroy() is called once per NIC queue, totall=
ing
>> > > > a total of 250 calls for the cards I am using.
>> > > >
>> > > > Ftrace output:
>> > > >
>> > > >         # perf ftrace --graph-opts depth=3D100,tail,noirqs -G
>> > > > rtnetlink_rcv_msg   /usr/sbin/tc qdisc replace dev eth0 root handl=
e 0x1: mq
>> > > > | grep \\$
>> > > >         7) $ 4335849 us  |        } /* mq_init */
>> > > >         7) $ 4339715 us  |      } /* qdisc_create */
>> > > >         11) $ 15844438 us |        } /* mq_attach */
>> > > >         11) $ 16129620 us |      } /* qdisc_graft */
>> > > >         11) $ 20469368 us |    } /* tc_modify_qdisc */
>> > > >         11) $ 20470448 us |  } /* rtnetlink_rcv_msg */
>> > > >
>> > > >         In this case, the rtnetlink_rcv_msg() took 20 seconds, and=
, while
>> > > > it
>> > > >         was running, the NIC was not being able to send any packet
>> > > >
>> > > > Going one step further, this matches what I described above:
>> > > >
>> > > >         # perf ftrace --graph-opts depth=3D100,tail,noirqs -G
>> > > > rtnetlink_rcv_msg   /usr/sbin/tc qdisc replace dev eth0 root handl=
e 0x1: mq
>> > > > | grep "\\@\|\\$"
>> > > >
>> > > >         7) $ 4335849 us  |        } /* mq_init */
>> > > >         7) $ 4339715 us  |      } /* qdisc_create */
>> > > >         14) @ 210619.0 us |                      } /* schedule */
>> > > >         14) @ 210621.3 us |                    } /* schedule_timeo=
ut */
>> > > >         14) @ 210654.0 us |                  } /*
>> > > > wait_for_completion_state */
>> > > >         14) @ 210716.7 us |                } /* __wait_rcu_gp */
>> > > >         14) @ 210719.4 us |              } /* synchronize_rcu_norm=
al */
>> > > >         14) @ 210742.5 us |            } /* synchronize_rcu */
>> > > >         14) @ 144455.7 us |            } /* __qdisc_destroy */
>> > > >         14) @ 144458.6 us |          } /* qdisc_put */
>> > > >         <snip>
>> > > >         2) @ 131083.6 us |                        } /* schedule */
>> > > >         2) @ 131086.5 us |                      } /* schedule_time=
out */
>> > > >         2) @ 131129.6 us |                    } /*
>> > > > wait_for_completion_state */
>> > > >         2) @ 131227.6 us |                  } /* __wait_rcu_gp */
>> > > >         2) @ 131231.0 us |                } /* synchronize_rcu_nor=
mal */
>> > > >         2) @ 131242.6 us |              } /* synchronize_rcu */
>> > > >         2) @ 152162.7 us |            } /* __qdisc_destroy */
>> > > >         2) @ 152165.7 us |          } /* qdisc_put */
>> > > >         11) $ 15844438 us |        } /* mq_attach */
>> > > >         11) $ 16129620 us |      } /* qdisc_graft */
>> > > >         11) $ 20469368 us |    } /* tc_modify_qdisc */
>> > > >         11) $ 20470448 us |  } /* rtnetlink_rcv_msg */
>> > > >
>> > > > From the stack trace, it appears that most of the time is spent wa=
iting
>> > > > for the
>> > > > RCU grace period to free the qdisc (!?):
>> > > >
>> > > >         static void __qdisc_destroy(struct Qdisc *qdisc)
>> > > >         {
>> > > >                 if (ops->destroy)
>> > > >                         ops->destroy(qdisc);
>> > > >
>> > > >                 call_rcu(&qdisc->rcu, qdisc_free_cb);
>> > > >
>> > >
>> > > call_rcu() is asynchronous, this is very different from synchronize_=
rcu().
>> >
>> > That is a good point. The offender is synchronize_rcu() is here.
>>
>> Should that be synchronize_net()?
>
>
> I think we should redesign lockdep_unregister_key() to work on a separate=
ly allocated piece of memory,
> then use kfree_rcu() in it.
>
> Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer=
 to

Lockdep requires the key object must be static:

 822 /*
 823  * Is this the address of a static object:
 824  */
 825 #ifdef __KERNEL__
 826 static int static_obj(const void *obj)
 827 {
 828         unsigned long addr =3D (unsigned long) obj;
 829
 830         if (is_kernel_core_data(addr))
 831                 return 1;
 832
 833         /*
 834          * keys are allowed in the __ro_after_init section.
 835          */
 836         if (is_kernel_rodata(addr))
 837                 return 1;
 838

I am afraid the best suggestion here would be just disabling LOCKDEP,
which is known for big overhead.

Thanks.

