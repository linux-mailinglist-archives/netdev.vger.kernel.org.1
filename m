Return-Path: <netdev+bounces-176185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37040A6945E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8D518908E4
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BA1DB55D;
	Wed, 19 Mar 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQx3B8rQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB43987D;
	Wed, 19 Mar 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400308; cv=none; b=Zzlm3XG8B4w/MJNm+HTAl+OR1K3gxlpX/KtG4HbQtnCIiCIN5dV/o2DeLKAv7yrucVUMwkUEe5UHin/qWYholUQTLleMfZPh7rAjLw3+Qt8TZO+V4gU9A3FGix86VnbQ6kH5rJQwgEuxAVGqArcgtqrFWACHTzRkmS/oF6XK8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400308; c=relaxed/simple;
	bh=z/G3Z2MGHQ+PPzlQ/Cme6/xxLN2nDgemY6+3EYWpYEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuwGgx7XiwWA/LHRLTfIa5G9RUHICcrYsdJ0kPqNd3eCXZk3nrOZWq7V/x5E7xVGvW3zIIjuXcypBWNLjhSJjCI5jraFjXU/ffUnS9aUlCCVlW+uxtf8fIYGpZGDCZRLi5XvfLy1CV7AcV86MVN6W5QdmFQyiIsG5Bh7zXG01Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQx3B8rQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB1FC4CEE4;
	Wed, 19 Mar 2025 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742400308;
	bh=z/G3Z2MGHQ+PPzlQ/Cme6/xxLN2nDgemY6+3EYWpYEA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LQx3B8rQo5k+Gw8tRpC7XGIsrv/VcLO9wsWTmr7+kp6mKUm1Qos9J/H5hIDbFurCz
	 efVzBenumv2HAzWA3EEDCpLQXXS4I/Ivf/ikE+REY9hEOYA+eeKgMYD9J2CPi2Xtxq
	 FR1JXoA2rDY5T3EzvkjbYCKrQctwrX+aIcmpipfuFwadQiIaEy0xYlEf8+AZ13bPuv
	 GMcDA37MWS5pgSZuCSjWbj77mkohJdqOfBj2QzV4FeOt5ViNJlrO7HzS7X8CzA0Bta
	 DcWv8fSBIsDlZV7bOpWr1WIktkOWbryf1cyMS6mAjB0dX49uBx5nHuCD8fllEzkQ7e
	 mVRyaoYhv+BHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E2C3FCE0BC5; Wed, 19 Mar 2025 09:05:07 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:05:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Breno Leitao <leitao@debian.org>, kuba@kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@amazon.com,
	rcu@vger.kernel.org, kasan-dev@googlegroups.com,
	netdev@vger.kernel.org
Subject: Re: tc: network egress frozen during qdisc update with debug kernel
Message-ID: <0e9dbde7-07eb-45f1-a39c-6cf76f9c252f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250319-meticulous-succinct-mule-ddabc5@leitao>
 <CANn89iLRePLUiBe7LKYTUsnVAOs832Hk9oM8Fb_wnJubhAZnYA@mail.gmail.com>
 <20250319-sloppy-active-bonobo-f49d8e@leitao>
 <5e0527e8-c92e-4dfb-8dc7-afe909fb2f98@paulmck-laptop>
 <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>

On Wed, Mar 19, 2025 at 04:08:48PM +0100, Eric Dumazet wrote:
> On Wed, Mar 19, 2025 at 4:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > On Wed, Mar 19, 2025 at 07:56:40AM -0700, Breno Leitao wrote:
> > > On Wed, Mar 19, 2025 at 03:41:37PM +0100, Eric Dumazet wrote:
> > > > On Wed, Mar 19, 2025 at 2:09 PM Breno Leitao <leitao@debian.org>
> > wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > I am experiencing an issue with upstream kernel when compiled with
> > debug
> > > > > capabilities. They are CONFIG_DEBUG_NET, CONFIG_KASAN, and
> > > > > CONFIG_LOCKDEP plus a few others. You can find the full
> > configuration at
> > > > > ....
> > > > >
> > > > > Basically when running a `tc replace`, it takes 13-20 seconds to
> > finish:
> > > > >
> > > > >         # time /usr/sbin/tc qdisc replace dev eth0 root handle
> > 0x1234: mq
> > > > >         real    0m13.195s
> > > > >         user    0m0.001s
> > > > >         sys     0m2.746s
> > > > >
> > > > > While this is running, the machine loses network access completely.
> > The
> > > > > machine's network becomes inaccessible for 13 seconds above, which
> > is far
> > > > > from
> > > > > ideal.
> > > > >
> > > > > Upon investigation, I found that the host is getting stuck in the
> > following
> > > > > call path:
> > > > >
> > > > >         __qdisc_destroy
> > > > >         mq_attach
> > > > >         qdisc_graft
> > > > >         tc_modify_qdisc
> > > > >         rtnetlink_rcv_msg
> > > > >         netlink_rcv_skb
> > > > >         netlink_unicast
> > > > >         netlink_sendmsg
> > > > >
> > > > > The big offender here is rtnetlink_rcv_msg(), which is called with
> > > > > rtnl_lock
> > > > > in the follow path:
> > > > >
> > > > >         static int tc_modify_qdisc() {
> > > > >                 ...
> > > > >                 netdev_lock_ops(dev);
> > > > >                 err = __tc_modify_qdisc(skb, n, extack, dev, tca,
> > tcm,
> > > > > &replay);
> > > > >                 netdev_unlock_ops(dev);
> > > > >                 ...
> > > > >         }
> > > > >
> > > > > So, the rtnl_lock is held for 13 seconds in the case above. I also
> > > > > traced that __qdisc_destroy() is called once per NIC queue, totalling
> > > > > a total of 250 calls for the cards I am using.
> > > > >
> > > > > Ftrace output:
> > > > >
> > > > >         # perf ftrace --graph-opts depth=100,tail,noirqs -G
> > > > > rtnetlink_rcv_msg   /usr/sbin/tc qdisc replace dev eth0 root handle
> > 0x1: mq
> > > > > | grep \\$
> > > > >         7) $ 4335849 us  |        } /* mq_init */
> > > > >         7) $ 4339715 us  |      } /* qdisc_create */
> > > > >         11) $ 15844438 us |        } /* mq_attach */
> > > > >         11) $ 16129620 us |      } /* qdisc_graft */
> > > > >         11) $ 20469368 us |    } /* tc_modify_qdisc */
> > > > >         11) $ 20470448 us |  } /* rtnetlink_rcv_msg */
> > > > >
> > > > >         In this case, the rtnetlink_rcv_msg() took 20 seconds, and,
> > while
> > > > > it
> > > > >         was running, the NIC was not being able to send any packet
> > > > >
> > > > > Going one step further, this matches what I described above:
> > > > >
> > > > >         # perf ftrace --graph-opts depth=100,tail,noirqs -G
> > > > > rtnetlink_rcv_msg   /usr/sbin/tc qdisc replace dev eth0 root handle
> > 0x1: mq
> > > > > | grep "\\@\|\\$"
> > > > >
> > > > >         7) $ 4335849 us  |        } /* mq_init */
> > > > >         7) $ 4339715 us  |      } /* qdisc_create */
> > > > >         14) @ 210619.0 us |                      } /* schedule */
> > > > >         14) @ 210621.3 us |                    } /* schedule_timeout
> > */
> > > > >         14) @ 210654.0 us |                  } /*
> > > > > wait_for_completion_state */
> > > > >         14) @ 210716.7 us |                } /* __wait_rcu_gp */
> > > > >         14) @ 210719.4 us |              } /* synchronize_rcu_normal
> > */
> > > > >         14) @ 210742.5 us |            } /* synchronize_rcu */
> > > > >         14) @ 144455.7 us |            } /* __qdisc_destroy */
> > > > >         14) @ 144458.6 us |          } /* qdisc_put */
> > > > >         <snip>
> > > > >         2) @ 131083.6 us |                        } /* schedule */
> > > > >         2) @ 131086.5 us |                      } /*
> > schedule_timeout */
> > > > >         2) @ 131129.6 us |                    } /*
> > > > > wait_for_completion_state */
> > > > >         2) @ 131227.6 us |                  } /* __wait_rcu_gp */
> > > > >         2) @ 131231.0 us |                } /*
> > synchronize_rcu_normal */
> > > > >         2) @ 131242.6 us |              } /* synchronize_rcu */
> > > > >         2) @ 152162.7 us |            } /* __qdisc_destroy */
> > > > >         2) @ 152165.7 us |          } /* qdisc_put */
> > > > >         11) $ 15844438 us |        } /* mq_attach */
> > > > >         11) $ 16129620 us |      } /* qdisc_graft */
> > > > >         11) $ 20469368 us |    } /* tc_modify_qdisc */
> > > > >         11) $ 20470448 us |  } /* rtnetlink_rcv_msg */
> > > > >
> > > > > From the stack trace, it appears that most of the time is spent
> > waiting
> > > > > for the
> > > > > RCU grace period to free the qdisc (!?):
> > > > >
> > > > >         static void __qdisc_destroy(struct Qdisc *qdisc)
> > > > >         {
> > > > >                 if (ops->destroy)
> > > > >                         ops->destroy(qdisc);
> > > > >
> > > > >                 call_rcu(&qdisc->rcu, qdisc_free_cb);
> > > > >
> > > >
> > > > call_rcu() is asynchronous, this is very different from
> > synchronize_rcu().
> > >
> > > That is a good point. The offender is synchronize_rcu() is here.
> >
> > Should that be synchronize_net()?
> >
> 
> I think we should redesign lockdep_unregister_key() to work on a separately
> allocated piece of memory,
> then use kfree_rcu() in it.
> 
> Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer to
> 
> struct ... {
>      struct lock_class_key;
>      struct rcu_head  rcu;
> }

Works for me!

                                                        Thanx, Paul

> > > > >         }
> > > > >
> > > > > So, from my newbie PoV, the issue can be summarized as follows:
> > > > >
> > > > >         netdev_lock_ops(dev);
> > > > >         __tc_modify_qdisc()
> > > > >           qdisc_graft()
> > > > >             for (i = 0; i <  255; i++)
> > > > >               qdisc_put()
> > > > >                 ____qdisc_destroy()
> > > > >                   call_rcu()
> > > > >               }
> > > > >
> > > > > Questions:
> > > > >
> > > > > 1) I assume the egress traffic is blocked because we are modifying
> > the
> > > > >    qdisc, which makes sense. How is this achieved? Is it related to
> > > > >    rtnl_lock?
> > > > >
> > > > > 2) Would it be beneficial to attempt qdisc_put() outside of the
> > critical
> > > > >    section (rtnl_lock?) to prevent this freeze?
> > > > >
> > > > >
> > > >
> > > > It is unclear to me why you have syncrhonize_rcu() calls.
> > >
> > > This is coming from:
> > >
> > >       __qdisc_destroy() {
> > >               lockdep_unregister_key(&qdisc->root_lock_key) {
> > >                       ...
> > >                       /* Wait until is_dynamic_key() has finished
> > accessing k->hash_entry. */
> > >                       synchronize_rcu();
> >

