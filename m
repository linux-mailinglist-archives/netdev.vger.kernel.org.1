Return-Path: <netdev+bounces-296626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bdwBDNvjJmrkmQIAu9opvQ
	(envelope-from <netdev+bounces-296626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:46:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C625658475
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:46:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=1wt.eu header.s=mail header.b=F2pcrZl7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296626-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=1wt.eu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4E8322CF8A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC0426EDE;
	Mon,  8 Jun 2026 15:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBF4279E3
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:06:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931185; cv=none; b=rnkWEYzxizDFmN5ofeyF3iOPbrJEAVKY0Tbl4fpzYMulWZDn8+bBuZoPnFjoxk2WOJUp1f4ecz3TJQ7FHuCvZn52yESFmlvAG04Qpo+Fz+y5LlzPNYX39FLuU2dfZfwGvhjjM3AhB6L6DQ/Ta18GIMCX3Nsbpgw/rNT1MjMTD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931185; c=relaxed/simple;
	bh=I88BegSto3+kNitB6kqvIqnIJzVLWXt+OPNwEUP1a04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3sDAI2jYULj3LCuPPA5j0dGb4/FrNQwtUv2unXEENuvEEipJg0hGiPF9VJ+3ZN/NZIu2a8NG71as5Jvam0LshG3wAf2ebLSboBby+/WMLpDDdh60ApHISPfuyvGSkgC94xXSzLhfhpau7liu3u5fG2/Ok2/aPcytAFCXfQNx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=F2pcrZl7; arc=none smtp.client-ip=51.159.59.229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1780931176; bh=Ir/GpmJ/KKeHQdGFw7gdehhXDFaca8MfgejuXXaaj74=;
	h=From:Message-ID:From;
	b=F2pcrZl7wvivWt9mwwfqC0HSz1EyN63HY+9FGRmnXPn0t2Gs/i1Hd79yJcmer2nzc
	 j+/q3WsjXRfRgoJnfkJ8udXkII5eWpy2MvhbxHEriCzcYJH2D3vOIoXmta29VdLKp1
	 IYcNWgUZeHQj9auIh7q1DhdE7FATeULPwplRn+BU=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 5E23CC0A10;
	Mon, 08 Jun 2026 17:06:16 +0200 (CEST)
Date: Mon, 8 Jun 2026 17:06:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: xietangxin <xietangxin@yeah.net>, Eric Dumazet <edumazet@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, Zhouyan Deng <dengzhouyan_nwpu@163.com>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aibaZyz4MT8Ixt0N@1wt.eu>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
 <aiaOor1JLLu5Xn75@1wt.eu>
 <90cb7e92-2451-4c67-9f35-6ff96b7efd77@yeah.net>
 <0e89ceb5-a2ae-4e7c-8fe2-5b6a89ba6ac5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e89ceb5-a2ae-4e7c-8fe2-5b6a89ba6ac5@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	URL_NUMERIC_IP(1.50)[10.0.0.1];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296626-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[w@1wt.eu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:xietangxin@yeah.net,m:edumazet@google.com,m:pablo@netfilter.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:dengzhouyan_nwpu@163.com,m:fw@strlen.de,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[yeah.net,google.com,netfilter.org,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,163.com,strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[1wt.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,yeah.net:email,1wt.eu:dkim,1wt.eu:mid,1wt.eu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C625658475

On Mon, Jun 08, 2026 at 09:14:26PM +0800, Jiayuan Chen wrote:
> 
> On 6/8/26 8:51 PM, xietangxin wrote:
> > 
> > On 6/8/2026 5:42 PM, Willy Tarreau wrote:
> > > On Mon, Jun 08, 2026 at 01:51:49AM -0700, Eric Dumazet wrote:
> > > > On Sat, Jun 6, 2026 at 4:06 AM xietangxin <xietangxin@yeah.net> wrote:
> > > > > 
> > > > > Hi Eric and netdev,
> > > > > 
> > > > > I noticed a significant TCP performance regression (QPS drop) when using
> > > > > iptables MASQUERADE with the `--random-fully` option, and I have bisected
> > > > > it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
> > > > > (tcp: secure_seq: add back ports to TS offset).
> > > > > 
> > > > > Here is the benchmark environment and test results.
> > > > > Environment:
> > > > > - Client & Server: 2 VMs
> > > > > - Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
> > > > > - Benchmark tool: wrk (short-lived connections with "Connection: close")
> > > > > 
> > > > > Test Commands
> > > > > 1. With random-fully:
> > > > >     # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE --random-fully
> > > > >     # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
> > > > > 2. Without random-fully:
> > > > >     # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE
> > > > >     # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
> > > > > 
> > > > > Test Results (QPS):
> > > > > 1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
> > > > >     - with random-fully:    18145.74, 15006.39, 15716.67
> > > > >     - without random-fully: 18556.36, 16339.22, 21506.02
> > > > > 
> > > > > 2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
> > > > >     - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)
> > > > >     - without random-fully: 17310.75, 20279.85, 18399.48
> > > > > 
> > > > > Is this performance degradation an expected side-effect of the security fix,
> > > > > or is there any sysctl param we should tune when `--random-fully` is
> > > > > required for high-concurrency short connections?
> > > > Hi Tangxin
> > > > 
> > > > I do not know why that patch would affect MASQUERADE performance.
> > > > 
> > > > Pablo, Florian, do you have an idea?
> > > I suspect it's because MASQUERADE can shuffle the ports around and
> > > break the end-to-end mapping. With host-based ISN the increments
> > > remain positive regardless of the ports, while with port-based
> > > increments if you shuffle ports around, two consecutive uses of
> > > the same port can end up showing a decreasing ISN, and some
> > > outgoing SYN will get an ACK instead of a SYN-ACK, then send an
> > > RST, and a SYN again, causing a degradation.
> > > 
> > > I'm not saying this is necessarily what happens here but based on the
> > > commit message description I suspect that this is what's happening
> > > here. There's always a tradeoff between ISN secrecy and reliability
> > > unfortunately.
> > > 
> > > Willy
> > Hi,
> > 
> > Willy, your hypothesis is 100% correct!
> > I captured the packets during the benchmark on the bad commit,
> > and the trace perfectly shows the "SYN -> ACK -> RST".
> > 
> > Here is the key snippet of the packet trace (Client: 10.0.0.2, Server: 10.0.0.1):
> > 
> > // 1. First connection closes, Server sends last ACK(410615916), entering TIME_WAIT.
> > 12105 08:54:39.128861 10.0.0.1 -> 10.0.0.2 TCP 80 -> 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827652 TSecr=370383870
> > 
> > // 2. ~200ms later, next short-conn reuses port 47824 via MASQUERADE --random-fully
> > 47637 08:54:39.332281 10.0.0.2 -> 10.0.0.1 TCP 47824 -> 80 [SYN] Seq=559739866 TSval=4137539723 TSecr=0
> > 
> > // 3. Server is sends a ACK with the old connection's expected ACK(410615916).
> > 48591 08:54:39.337692 10.0.0.1 -> 10.0.0.2 TCP 80 -> 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827858 TSecr=370383870
> > 
> > // 4. Client receives the unexpected old ACK, responds with RST, and has to retry the connection.
> > 48600 08:54:39.337799 10.0.0.2 -> 10.0.0.1 TCP 47824 -> 80 [RST] Seq=410615916 Win=0
> > 
> > 
> > Are there any architectural recommendations we should consider here,
> > or is this considered an acceptable trade-off for security?
> 
> 
> It's classic PAWS problem when packets go through NAT/Gateway.
> 
> Can you test the performance with following different two configs (client) ?
> 
>     sysctl -w net.ipv4.tcp_timestamps=2
> 
>     sysctl -w net.ipv4.tcp_timestamps=0

The thing is, nothing forces a server to use PAWS to distinguish SYNs,
and some OSes only apply the spec to the letter (at least Solaris in
my experience). The spec basically says that PAWS protects against
duplicate non-SYN segments, and duplicate SYNs while there is a
connection. So while Linux (and other OSes) nicely covers the case
of the transition from TIME_WAIT to SYN_RECV, others do not always do
it.

Regardless, while I hate it when we play borderline games with TCP for
the sake of supposed security issues that can only be demonstrated in
a lab, we must admit that masquerading remains an issue when the same
port range is shared between multiple hosts, even with PAWS since there
is no reason for multiple hosts to have the same clock.

Willy

