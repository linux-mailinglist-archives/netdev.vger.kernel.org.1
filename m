Return-Path: <netdev+bounces-27888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0977D852
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A875C1C20EAB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA8E1C06;
	Wed, 16 Aug 2023 02:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F017E8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33329C433C8;
	Wed, 16 Aug 2023 02:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692152290;
	bh=SoINC6XP8wlWrAf6zL0wlSm33DKT99HH6ua5hps/aho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MlQz3e46Hh9A+v1P+CBv7yvc5s87+f/LFAl6TsroKuTDbfNn36PzaiLEaHci+NRa2
	 ehUqemfDtjx1gMGzmI3wXLMLPn5kY+f6txv62WVSSXM08u2BAfNV8uF+ISR3Ti91cq
	 rEGxK4hI0501I+WMJA/lXIBz/8+E3C+izNy0WQlz7WSkzSBob8ACjX7htZ4Kjl+WBR
	 xaeKG2uceZZr9QagyDcmCa4WfkHfDj4ksjs6emld97VD1nN88LwmJlbFFl4zekh5ht
	 s2XlKRYXf5JheEUXzpSkaPanzvajhBx1VpUaKg1+G/IvQjnlTVraq/IKxF8l3HjTXa
	 ENxecpsP6CePw==
Date: Tue, 15 Aug 2023 19:18:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: davem@davemloft.net, andrey.zhadchenko@virtuozzo.com,
 dev@openvswitch.org, brauner@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com,
 syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: reject negative ifindex
Message-ID: <20230815191809.2d18c9f5@kernel.org>
In-Reply-To: <f7t1qg4zddd.fsf@redhat.com>
References: <20230814203840.2908710-1-kuba@kernel.org>
	<f7t1qg4zddd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 08:41:50 -0400 Aaron Conole wrote:
> > Validate the inputes. Now the second command correctly returns:  
> 
> s/inputes/inputs/

Thanks, fixed when applying

> > $ ./cli.py --spec netlink/specs/ovs_vport.yaml \
> > 	 --do new \
> > 	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'
> >
> > lib.ynl.NlError: Netlink error: Numerical result out of range
> > nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
> > 	error: -34	extack: {'msg': 'integer out of range', 'unknown': [[type:4 len:36] b'\x0c\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x03\x00\xff\xff\xff\x7f\x00\x00\x00\x00\x08\x00\x01\x00\x08\x00\x00\x00'], 'bad-attr': '.ifindex'}
> >
> > Accept 0 since it used to be silently ignored.
> >
> > Fixes: 54c4ef34c4b6 ("openvswitch: allow specifying ifindex of new interfaces")
> > Reported-by: syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > CC: pshelar@ovn.org
> > CC: andrey.zhadchenko@virtuozzo.com
> > CC: brauner@kernel.org
> > CC: dev@openvswitch.org
> > ---  
> 
> Thanks for the quick follow up.  I accidentally broke my system trying
> to setup to reproduce the syzbot splat.

Ah. Syzbot pointed at my commit so I thought others will just think
"not my bug" :)

> The attribute here isn't used by the ovs-vswitchd, so probably why we
> never caught an issue before.  I'll think about how to improve the
> fuzzing on the ovs module.  At the very least, maybe we can have some
> additional checks in the netlink selftest.

Speaking of fuzzing - reaching out to Dmitry crossed my mind.
When the first netlink specs got merged we briefly discussed
using them to guide syzbot a little. But then I thought - syzbot did
find this fairly quickly, it's more that previously we apparently had
no warning or crash for negative ifindex so there was no target to hit.

> I noticed that since I copied the definitions when building
> ovs-dpctl.py, I have the same kind of mistake there (using unsigned for
> ifindex).  I can submit a follow up to correct that definition.  Also,
> we might consider correcting the yaml.

FWIW I left the nla_put_u32() when outputting ifindex in the kernel as
well. I needed s32 for the range because min and max are 16 bit (to
conserve space in the policy) so I could not express the positive limit
on u32. Whether ifindex is u32 or s32 is a bit of a philosophical
question to me, as it only takes positive 31b values...

