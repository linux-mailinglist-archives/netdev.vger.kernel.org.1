Return-Path: <netdev+bounces-287521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB6pA+FVBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:43:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA95317FF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0013B3033F7F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6753DD871;
	Wed, 13 May 2026 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/iwr7jP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWvPXexi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED33914F0
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669021; cv=pass; b=K33rccEEUEOWaAPrnraMx15UirjQmO9SjIjOgjjnQaykMLJ+khvzaUNacRr/vjOaRWoF4l2jvSR50XBeCs8tBJeGlateAA4JgrPfdq/DBgKQgN+O/VJQyyjCOWDHCNNFKAwr5BXSMjYqNB6TRFLBncT1DqeSmFGvs6HK4iYc9AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669021; c=relaxed/simple;
	bh=M3yi0m59GWu+ht7J+laSLN+a+tUl3SFmteOOKCm+tpk=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNTyQ3jAU4s2ORCporB3Ap4c+8CIuCZ94IEBXabVpDWtISafEuZydadej3Mug2hJiS0455/AfM84qPnZk9N+ITxK09N21DLU/UTjpOvTeOf6SiEM+KNjiX/ryldzPD7f7gTe3okDrTe0Okiu2k5NTggQ1Hxcln9M4NICXY5wwwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/iwr7jP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWvPXexi; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o29i8O2aaVs4bq4291ofGhSS+7I8Uy86KU6SAHMIQdc=;
	b=F/iwr7jPFNKFgwTLtwu0rcOLFmC4gAkfJFC/zFVJqcfvZT/bKS8H+rqX3TU2aNffOdYsRR
	iZw1jBwWeVM603qi8YOoBcjKr/UfI/c2or7ZnidfbDdDbIcXwAJs0DV43Ct2yzs7C5SUh7
	TDNX74h1gO9N83qFtD4LEEUPsl0X0qA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-u30WZAO4MmmFS4cAnZKePQ-1; Wed, 13 May 2026 06:43:38 -0400
X-MC-Unique: u30WZAO4MmmFS4cAnZKePQ-1
X-Mimecast-MFC-AGG-ID: u30WZAO4MmmFS4cAnZKePQ_1778669017
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bcf70e19516so331429866b.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778669017; cv=none;
        d=google.com; s=arc-20240605;
        b=I+0A+aRfPrZ8BpyiQOw9dwAxyVkWtzmfNVUEFvJ0s7mIZdAgQQ53m1lDxuMeW4rrEU
         xhOQbgqpKIS520tOpOOfY3I87gLvSYJeikElerPfzJcyqdWyBiZg2DNRUFOLFqytT2qY
         yOB+a5bHG2PgvKRfRGMOhh7PgYCv7OcvfIZs0DGbJ0XWWXF20LYzNdZrz8+lOsCIBxXH
         Eo1AIeQpIxLH1ajy7X2/dWgfaScdy7fdlV5dIPfXkNfLOx0SPTyJpHyuNkPVviMEdKtA
         S5ZYjQU1sHs8B2UJ2vwmYIBlqgyTxEAW3n/yfAP02juaMzoXWQRhPBW9AUvHvAqzqk7+
         FnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=o29i8O2aaVs4bq4291ofGhSS+7I8Uy86KU6SAHMIQdc=;
        fh=j5CqZHL5zV7C/kjSXjXGxR17zjEpontygbIJoR8m8+Q=;
        b=CgkRQGpQe6k3we6yX6jKld8mNZzrSbe9juKvJPhAMU82GQFMnGcIXAYLWqnALDJ0/n
         pLKIbNLfdwoecNhLUhq/wV0U3kWzUty1cX9N79WX2WcOE7AhasujoE0SWMABWdrF8LqS
         ZRV3z2FxQZheyQak0l8UAK8MHwVoUljBIx/2UsvcVzbtvGriXloRjOwKf+Q7KDbbDadA
         FE/E6piOKsjB7LQRCB65u756xqkh+mmbZCIWi2OfIh3+W0jagmE0nJqcWx7/t9fp755a
         tiJRnv1kp7/2DI3AL/iy9mvJclRIKDEwp7RZm2+ms8vxYY9a1DT6GR7Rq8vVjAiLL9p3
         sHYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669017; x=1779273817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o29i8O2aaVs4bq4291ofGhSS+7I8Uy86KU6SAHMIQdc=;
        b=QWvPXexiapeoeRjvz39Jm75YSkdRJ8081HxIaUBXWWJiPYaGBiJDakKHmCAmCFEMdR
         jNpeY9NRxt2W93Q/2DyJAlr5ia86rwqYPpEwAw2JuZ6roSdVII/bpGFxsBfRY7FI7XNH
         e3PMIEqHUyOi978HRICGbTUS/+7ToGTgS1rU1Ce+Lp8TvbVbGzMDafBLFe8QfNgvhEHJ
         qzyzqJgiPXAx/cTjHAMfFpe3Krspk5xZOWD3Pr+l2689Iusxxq1kSxC+Tl3tMmNVdaUp
         XgY9WzpxI2ZrtJv7DzlVluu14Fd+b2j+Ahw/K2wp79J4baTwwffguIkn3lPl5bq9g6Sn
         +J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669017; x=1779273817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o29i8O2aaVs4bq4291ofGhSS+7I8Uy86KU6SAHMIQdc=;
        b=PeMzP7f8KaqLnujVD0ftj4XNeRF88jEYTmK1kc4GjhcWrKZY5r5+v5PDenvQ/jLF10
         PB8YWIKMEmzyNVDMsjZYiXn3Ox3pkvTnpjjcCfwrzD0rxdG4aFzGktzPF58x+ALyypfh
         W+pb9csMlS8RvU8iBZDe9s80rqYaEVtncjd/lYy/vQMiYgSfzYTj/RZrwtpcFr+AI7F2
         lEWT6fzgUnhsc5Yl9yvVQ3lM3qhEHJlwS4UXPEt4/nyrYJujvSVz7Bz7hRYCR/OUjhNa
         2FkMvAmA4EHNw58BCP6LW4cl4W6poPVl6Yp4ao1+82NXGOSDN/LcDVQcVjDPDIyR7fVg
         oBAw==
X-Gm-Message-State: AOJu0YwdAZZ17rzeglIsa4ZkV3DG3ls0M2S5tZwKCkrgA6yMuDF1CSU0
	n47z0fDzI0r7ekLW8fWnnlSlS1DW2gza9xUrViPIXUSDcR7SYy5zaRKxM/WuXmMmrJaF7utp577
	58ivfIjUmyVOk4hzC7vnhOe+AWQkY2qObGpNBIU7rJ2kxgqBYx4kUXcGYm3q56kwASGPITf6Fl6
	Me7BIDEfOOAiGXRCmuNiOC4BUYbL1VwjLA
X-Gm-Gg: Acq92OEH3G6Mz6uep1PkYRa+hFQOOa1eC5NH3h7HEsBkYjkCz4VHumMHgx+PDJY+miq
	Od1ZpBlHlly8gkY51qAVdG5v9akMEDrv+QHvMMG1as3KvDt99CpxpXxYFcrkJoDpvROAu6b0Pij
	a6Pg6x+yCK8hKm47ahYRAVQZK+T0bJx/7g8p1WWHQNNi/RHsCpcVUzNUyCCoHeMKnpf1Mi59qIy
	BI6o5zF
X-Received: by 2002:a17:907:2682:b0:bd1:3b7e:bf8f with SMTP id a640c23a62f3a-bd3c14066aamr178538066b.35.1778669016904;
        Wed, 13 May 2026 03:43:36 -0700 (PDT)
X-Received: by 2002:a17:907:2682:b0:bd1:3b7e:bf8f with SMTP id
 a640c23a62f3a-bd3c14066aamr178534666b.35.1778669016511; Wed, 13 May 2026
 03:43:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 10:43:34 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 10:43:34 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260505084253.998548-1-amorenoz@redhat.com> <20260505084253.998548-2-amorenoz@redhat.com>
 <1cc38ea2-74ac-49f5-97b1-b9404726bdbc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1cc38ea2-74ac-49f5-97b1-b9404726bdbc@redhat.com>
Date: Wed, 13 May 2026 10:43:34 +0000
X-Gm-Features: AVHnY4IqdpXoUaowxBFlRQCjpMpWwH_wD8ffDvD-nk8q6mmXS34mZRjxsIUlLoI
Message-ID: <CAG=2xmNvgmQypHX3aznU0ZbQZrPCRZ95XeBRsWAsryryxr_W0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: openvswitch: make flow_table an rcu pointer
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"open list:OPENVSWITCH" <dev@openvswitch.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 98BA95317FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287521-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:03:45PM +0200, Paolo Abeni wrote:
> On 5/5/26 10:42 AM, Adrian Moreno wrote:
> > @@ -752,12 +759,16 @@ static struct genl_family dp_packet_genl_family _=
_ro_after_init =3D {
> >  static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stat=
s *stats,
> >  			 struct ovs_dp_megaflow_stats *mega_stats)
> >  {
> > +	struct flow_table *table =3D ovsl_dereference(dp->table);
> >  	int i;
> >
> >  	memset(mega_stats, 0, sizeof(*mega_stats));
> > +	memset(stats, 0, sizeof(*stats));
>
> Is this an unrelated bugfix, preventing random values from stack
> clobbering the stats? Should it land to a separate fix for net?

I don't think is a but, although it's definitely code that can be
improved.
Before this patch, all members of "stats" were being set in this
function so there is no stack-pollution. This patch introduces a
possibility of not setting mega_stats->n_stats if we fail to dereference
the flow table, so clearing all fields becomes mandatory.

Would this qualify for a backportable bug-fix?

Actually, now that I look at this hunk, I realize this line should be
removed:

    stats->n_hit =3D stats->n_missed =3D stats->n_lost =3D 0;

>
> > @@ -1501,8 +1537,13 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb=
, struct netlink_callback *cb)
> >  		rcu_read_unlock();
> >  		return -ENODEV;
> >  	}
> > +	table =3D rcu_dereference_ovsl(dp->table);
>
> Possibly:
> 	table =3D rcu_dereference(dp->table);
> would be more accurate

You're right! Thanks.

>
> > @@ -518,6 +524,7 @@ void ovs_flow_tbl_destroy(struct flow_table *table)
> >  	call_rcu(&mc->rcu, mask_cache_rcu_cb);
> >  	call_rcu(&ma->rcu, mask_array_rcu_cb);
>
> This is always invoked after a rcu grace period, it would be probably
> nice to follow-up, not necessarly in this series, moving the above
> call_rcu together with the call_rcu(table). Such statements could be
> bundled in a new helper.
>

Sorry, bundled together with what exactly?
Are you refering to the fact that full table deletion now spans over two
rcu periods?

Thanks.
Adri=C3=A1n


