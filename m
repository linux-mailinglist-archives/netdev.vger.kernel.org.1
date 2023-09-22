Return-Path: <netdev+bounces-35861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1507AB67D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 18B8728216B
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477441E2C;
	Fri, 22 Sep 2023 16:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419B1F16D
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 16:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AB1C433C7;
	Fri, 22 Sep 2023 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695401591;
	bh=Coz3Yl8gyVNhqJfoalzt7Vb3PJVy+62a+mmfUn6aN7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GbO2f36890za+f5LzE7nK72ySYuz9Bs9sjbQrdTv8fauGHJ8o5GJ4jGV0jD15myaA
	 eEwddmQuNzxrHH+usPmYY8BqoRCPwwqVvkfjEPDwaUVuRFV/WnajwMy4tFQbfjY1gh
	 51ODmboXzGzMj1qmPUTs14rjncrE/1Uu8tSAKd/pM7jf7idqORWTBoNoZALUelWs7y
	 BZFB3Zw2zeWnTlT8kZTuLkZfbgbIa5pCeux5nU5PE/CDIkDga4lzxb1s5DJNZH+W4o
	 6Zsw/eBApaMPyPA+dKb6Fbn2i9Gv+9s3tFDmOW0ldl0LJufDcIWaiAJJQv6tkGEnHA
	 uZ0bSajkIagRA==
Message-ID: <196ae335f7e1de97cfed03b51978aac0dbb32e56.camel@kernel.org>
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org, 
	neilb@suse.de, chuck.lever@oracle.com, netdev@vger.kernel.org
Date: Fri, 22 Sep 2023 12:53:09 -0400
In-Reply-To: <ZQ2+1NhagxR5bZF+@lore-desk>
References: 
	<b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
	 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
	 <ZQ2+1NhagxR5bZF+@lore-desk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-09-22 at 18:20 +0200, Lorenzo Bianconi wrote:
> > On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
> > > Introduce write_threads and write_v4_end_grace netlink commands simil=
ar
> > > to the ones available through the procfs.
> > > Introduce nfsd_nl_server_status_get_dumpit netlink command in order t=
o
> > > report global server metadata.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > This patch can be tested with user-space tool reported below:
> > > https://github.com/LorenzoBianconi/nfsd-netlink.git
> > > ---
> > > =A0Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
> > > =A0fs/nfsd/netlink.c                     | 30 ++++++++
> > > =A0fs/nfsd/netlink.h                     |  5 ++
> > > =A0fs/nfsd/nfsctl.c                      | 98 +++++++++++++++++++++++=
++++
> > > =A0include/uapi/linux/nfsd_netlink.h     | 11 +++
> > > =A05 files changed, 177 insertions(+)
> > >=20
> > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
> > > index 403d3e3a04f3..fa1204892703 100644
> > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > @@ -62,6 +62,15 @@ attribute-sets:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0name: compound-ops
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0type: u32
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0multi-attr: true
> > > +  -
> > > +    name: server-attr
> > > +    attributes:
> > > +      -
> > > +        name: threads
> > > +        type: u16
> >=20
> > 65k threads ought to be enough for anybody!
>=20
> maybe u8 is fine here :)
>=20

No, I was just kidding. u16 is fine. We should allow for large-scale
machines. Heck, we might even want to just make it u32. Who knows how
many threads we'll be needing in 10 years?

> >=20
> > > +      -
> > > +        name: v4-grace
> > > +        type: u8
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > =A0operations:
> > > =A0=A0=A0list:
> > > @@ -72,3 +81,27 @@ operations:
> > > =A0=A0=A0=A0=A0=A0=A0dump:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0pre: nfsd-nl-rpc-status-get-start
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0post: nfsd-nl-rpc-status-get-done
> > > +    -
> > > +      name: threads-set
> > > +      doc: set the number of running threads
> > > +      attribute-set: server-attr
> > > +      flags: [ admin-perm ]
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - threads
> > > +    -
> > > +      name: v4-grace-release
> > > +      doc: release the grace period for nfsd's v4 lock manager
> > > +      attribute-set: server-attr
> > > +      flags: [ admin-perm ]
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - v4-grace
> > > +    -
> > > +      name: server-status-get
> > > +      doc: dump server status info
> > > +      attribute-set: server-attr
> > > +      dump:
> > > +        pre: nfsd-nl-server-status-get-start
> > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > index 0e1d635ec5f9..783a34e69354 100644
> > > --- a/fs/nfsd/netlink.c
> > > +++ b/fs/nfsd/netlink.c
> > > @@ -10,6 +10,16 @@
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > =A0#include <uapi/linux/nfsd_netlink.h>
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > +/* NFSD_CMD_THREADS_SET - do */
> > > +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SER=
VER_ATTR_THREADS + 1] =3D {
> > > +	[NFSD_A_SERVER_ATTR_THREADS] =3D { .type =3D NLA_U16, },
> > > +};
> > > +
> > > +/* NFSD_CMD_V4_GRACE_RELEASE - do */
> > > +static const struct nla_policy nfsd_v4_grace_release_nl_policy[NFSD_=
A_SERVER_ATTR_V4_GRACE + 1] =3D {
> > > +	[NFSD_A_SERVER_ATTR_V4_GRACE] =3D { .type =3D NLA_U8, },
> > > +};
> > > +
> > > =A0/* Ops table for nfsd */
> > > =A0static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > > =A0	{
> > > @@ -19,6 +29,26 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
> > > =A0		.done	=3D nfsd_nl_rpc_status_get_done,
> > > =A0		.flags	=3D GENL_CMD_CAP_DUMP,
> > > =A0	},
> > > +	{
> > > +		.cmd		=3D NFSD_CMD_THREADS_SET,
> > > +		.doit		=3D nfsd_nl_threads_set_doit,
> > > +		.policy		=3D nfsd_threads_set_nl_policy,
> > > +		.maxattr	=3D NFSD_A_SERVER_ATTR_THREADS,
> > > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > +	},
> > > +	{
> > > +		.cmd		=3D NFSD_CMD_V4_GRACE_RELEASE,
> > > +		.doit		=3D nfsd_nl_v4_grace_release_doit,
> > > +		.policy		=3D nfsd_v4_grace_release_nl_policy,
> > > +		.maxattr	=3D NFSD_A_SERVER_ATTR_V4_GRACE,
> > > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > +	},
> > > +	{
> > > +		.cmd	=3D NFSD_CMD_SERVER_STATUS_GET,
> > > +		.start	=3D nfsd_nl_server_status_get_start,
> > > +		.dumpit	=3D nfsd_nl_server_status_get_dumpit,
> > > +		.flags	=3D GENL_CMD_CAP_DUMP,
> > > +	},
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > =A0struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > index d83dd6bdee92..2e98061fbb0a 100644
> > > --- a/fs/nfsd/netlink.h
> > > +++ b/fs/nfsd/netlink.h
> > > @@ -12,10 +12,15 @@
> > > =A0#include <uapi/linux/nfsd_netlink.h>
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > =A0int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> > > +int nfsd_nl_server_status_get_start(struct netlink_callback *cb);
> > > =A0int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > =A0int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > > =A0				  struct netlink_callback *cb);
> > > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *=
info);
> > > +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_i=
nfo *info);
> > > +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
> > > +				     struct netlink_callback *cb);
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > =A0extern struct genl_family nfsd_nl_family;
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index b71744e355a8..c631b59b7a4f 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1694,6 +1694,104 @@ int nfsd_nl_rpc_status_get_done(struct netlin=
k_callback *cb)
> > > =A0	return 0;
> > > =A0}
> > > =A0
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > +/**
> > > + * nfsd_nl_threads_set_doit - set the number of running threads
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *=
info)
> > > +{
> > > +	u16 nthreads;
> > > +	int ret;
> > > +
> > > +	if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
> > > +		return -EINVAL;
> > > +
> > > +	nthreads =3D nla_get_u16(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
> > > +
> > > +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred())=
;
> > > +	return ret =3D=3D nthreads ? 0 : ret;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_v4_grace_release_doit - release the nfs4 grace period
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_i=
nfo *info)
> > > +{
> > > +#ifdef CONFIG_NFSD_V4
> > > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_i=
d);
> > > +
> > > +	if (!info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE])
> > > +		return -EINVAL;
> > > +
> > > +	if (nla_get_u8(info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE]))
> > > +		nfsd4_end_grace(nn);
> > > +
> >=20
> > To be clear here. Issuing this with anything but 0 will end the grace
> > period. A value of 0 is ignored. It might be best to make the value not
>=20
> I tried to be aligned with write_v4_end_grace() here but supporting just =
1 (or
> any other non-zero value) and skipping 'Y/y'. If we send 0 it should skip=
 the
> release action.
>=20
> > matter at all. Do we have to send down a value at all?
>=20
> I am not sure if ynl supports a doit operation with a request with no par=
ameters.
> @Chuck, Jakub: any input here?
>=20
>=20
That was the way the original interface worked, but it has turned out to
be somewhat klunky. In fact, the whole nfsdcld upcall scheme is pretty
klunky altogether. It could really use a rework such that it doesn't
require so much upcalling, and it would be _really_ nice to ditch
rpc_pipefs.

I think it might be best not to add this field to the interface just
yet. I think we might want to consider reworking nfsdcld with an upcall
scheme based around netlink instead of rpc.pipefs.

What might be good to add to this interface in the nearer term is stuff
like the listener port configuration, the versions being served, etc.
IOW, I think with this patch, you want to aim to have rpc.nfsd(8) talk
to the kernel via netlink instead of nfsdfs.

> >=20
> > > +	return 0;
> > > +#else
> > > +	return -EOPNOTSUPP;
> > > +#endif /* CONFIG_NFSD_V4 */
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_server_status_get_start - Prepare server_status_get dumpi=
t
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Return values:
> > > + *   %0: The server_status_get command may proceed
> > > + *   %-ENODEV: There is no NFSD running in this namespace
> > > + */
> > > +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net=
_id);
> > > +
> > > +	return nn->nfsd_serv ? 0 : -ENODEV;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_server_status_get_dumpit - dump server status info
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
> > > +				     struct netlink_callback *cb)
> > > +{
> > > +	struct net *net =3D sock_net(skb->sk);
> > > +#ifdef CONFIG_NFSD_V4
> > > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > +#endif /* CONFIG_NFSD_V4 */
> > > +	void *hdr;
> > > +
> > > +	if (cb->args[0]) /* already consumed */
> > > +		return 0;
> > > +
> > > +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
> > > +			  &nfsd_nl_family, NLM_F_MULTI,
> > > +			  NFSD_CMD_SERVER_STATUS_GET);
> > > +	if (!hdr)
> > > +		return -ENOBUFS;
> > > +
> > > +	if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net=
)))
> > > +		return -ENOBUFS;
> > > +#ifdef CONFIG_NFSD_V4
> > > +	if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
> > > +		return -ENOBUFS;
> > > +#endif /* CONFIG_NFSD_V4 */
> > > +
> > > +	genlmsg_end(skb, hdr);
> > > +	cb->args[0] =3D 1;
> > > +
> > > +	return skb->len;
> > > +}
> > > +
> > > =A0/**
> > > =A0=A0* nfsd_net_init - Prepare the nfsd_net portion of a new net nam=
espace
> > > =A0=A0* @net: a freshly-created network namespace
> > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
> > > index c8ae72466ee6..b82fbc53d336 100644
> > > --- a/include/uapi/linux/nfsd_netlink.h
> > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > @@ -29,8 +29,19 @@ enum {
> > > =A0	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +enum {
> > > +	NFSD_A_SERVER_ATTR_THREADS =3D 1,
> > > +	NFSD_A_SERVER_ATTR_V4_GRACE,
> > > +
> > > +	__NFSD_A_SERVER_ATTR_MAX,
> > > +	NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
> > > +};
> > > +
> > > =A0enum {
> > > =A0	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > +	NFSD_CMD_THREADS_SET,
> > > +	NFSD_CMD_V4_GRACE_RELEASE,
> > > +	NFSD_CMD_SERVER_STATUS_GET,
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0	__NFSD_CMD_MAX,
> > > =A0	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

