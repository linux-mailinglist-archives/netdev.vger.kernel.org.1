Return-Path: <netdev+bounces-37416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0E7B53F3
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E461C280FA3
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2718E28;
	Mon,  2 Oct 2023 13:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F5613E
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC6BC433C8;
	Mon,  2 Oct 2023 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696253150;
	bh=rC5LeS/E4y7Ju4SRFC7Yoq5dzRfnMvaFKthqPf/GKKw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OHnPp5R+SinZuqXQNR2a9IPhKIQlMPRPsI8/i7JFqRC836Lby+OGZ/EA8R2YRJCGc
	 VQxCTtIupC991CghzoCNgzVUvxG0LXtAJupj6hzo+21II4fEGPl8juIDcabeU7qmfZ
	 onONKkiLflxyTPHrp/o5MbsjzcCYhq5GoJpDd+RcILupZbW/G8JQT1hf8YfCbNHI6h
	 +QCmYxBJgB2dKcAiSve96QrejGMh0xff2193DNkRya+WpDbrlJcxjIr8D5Eeowg3tE
	 8iJiGeT/f6H8E2oZ7/otWu/La6dWIiXILTMN5YFYSMEJuv8KggiuiAU0290x4F+1D7
	 pbcvfatywn+0Q==
Message-ID: <a1ab72d41a502906ea31b983f147ae75f6b0e3a2.camel@kernel.org>
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org, 
	lorenzo.bianconi@redhat.com, netdev@vger.kernel.org
Date: Mon, 02 Oct 2023 09:25:48 -0400
In-Reply-To: <ZRbUp0gsLv9PqriL@tissot.1015granger.net>
References: 
	<27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
	 <169576951041.19404.9298873670065778737@noble.neil.brown.name>
	 <ZRbUp0gsLv9PqriL@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-09-29 at 09:44 -0400, Chuck Lever wrote:
> On Wed, Sep 27, 2023 at 09:05:10AM +1000, NeilBrown wrote:
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index b71744e355a8..07e7a09e28e3 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1694,6 +1694,147 @@ int nfsd_nl_rpc_status_get_done(struct netlin=
k_callback *cb)
> > >  	return 0;
> > >  }
> > > =20
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
> > > +	u32 nthreads;
> > > +	int ret;
> > > +
> > > +	if (!info->attrs[NFSD_A_CONTROL_PLANE_THREADS])
> > > +		return -EINVAL;
> > > +
> > > +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_CONTROL_PLANE_THREADS])=
;
> > > +
> > > +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred())=
;
> > > +	return ret =3D=3D nthreads ? 0 : ret;
> > > +}
> > > +
> > > +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_call=
back *cb,
> > > +			    int cmd, int attr, u32 val)
> > > +{
> > > +	void *hdr;
> > > +
> > > +	if (cb->args[0]) /* already consumed */
> > > +		return 0;
> > > +
> > > +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
> > > +			  &nfsd_nl_family, NLM_F_MULTI, cmd);
> > > +	if (!hdr)
> > > +		return -ENOBUFS;
> > > +
> > > +	if (nla_put_u32(skb, attr, val))
> > > +		return -ENOBUFS;
> > > +
> > > +	genlmsg_end(skb, hdr);
> > > +	cb->args[0] =3D 1;
> > > +
> > > +	return skb->len;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_threads_get_dumpit - dump the number of running threads
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_c=
allback *cb)
> > > +{
> > > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
> > > +				NFSD_A_CONTROL_PLANE_THREADS,
> > > +				nfsd_nrthreads(sock_net(skb->sk)));
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_max_blksize_set_doit - set the nfs block size
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_in=
fo *info)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_i=
d);
> > > +	struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_BLKSIZ=
E];
> > > +	int ret =3D 0;
> > > +
> > > +	if (!attr)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +	if (nn->nfsd_serv) {
> > > +		ret =3D -EBUSY;
> > > +		goto out;
> > > +	}
> >=20
> > This code is wrong... but then the original in write_maxblksize is wron=
g
> > to, so you can't be blamed.
> > nfsd_max_blksize applies to nfsd in ALL network namespaces.  So if we
> > need to check there are no active services in one namespace, we need to
> > check the same for *all* namespaces.
>=20
> Yes, the original code does look strange and is probably incorrect
> with regard to its handling of the mutex. Shall we explore and fix
> that issue in the nfsctl code first so that it can be backported to
> stable kernels?
>=20
>=20
> > I think we should make nfsd_max_blksize a per-namespace value.
>=20
> That is a different conversation.
>=20
> First, the current name of this tunable is incongruent with its
> actual function, which is to specify the maximum network buffer size
> that is allocated when the NFSD service pool is created. We should
> find a more descriptive and specific name for this element in the
> netlink protocol.
>=20
> Second, it does seem like a candidate for becoming namespace-
> specific, but TBH I'm not familiar enough with its current user
> space consumers to know if that change would be welcome or fraught.
>=20
> Since more discussion, research, and possibly a fix are needed, we
> might drop max_blksize from this round and look for one or two
> other tunables to convert for the first round.
>=20
>=20

I think we need to step back a bit further even, and consider what we
want this to look like for users. How do we expect users to interact
with these new interfaces in the future?

Most of these settings are things that are "set and forget" and things
that we'd want to set up before we ever start any nfsd threads. I think
as an initial goal here, we ought to aim to replace the guts of
rpc.nfsd(8). Make it (preferentially) use the netlink interfaces for
setting everything instead of writing to files under /proc/fs/nfsd.

That gives us a clear set of interfaces that need to be replaced as a
first step, and gives us a start on integrating this change into nfs-
utils.

> > > +
> > > +	nfsd_max_blksize =3D nla_get_u32(attr);
> > > +	nfsd_max_blksize =3D max_t(int, nfsd_max_blksize, 1024);
> > > +	nfsd_max_blksize =3D min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE=
);
> > > +	nfsd_max_blksize &=3D ~1023;
> > > +out:
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> > > +				   struct netlink_callback *cb)
> > > +{
> > > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
> > > +				NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
> > > +				nfsd_max_blksize);
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_max_conn_set_doit - set the max number of connections
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info =
*info)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_i=
d);
> > > +	struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_CONN];
> > > +
> > > +	if (!attr)
> > > +		return -EINVAL;
> > > +
> > > +	nn->max_connections =3D nla_get_u32(attr);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> > > +				struct netlink_callback *cb)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net=
_id);
> > > +
> > > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
> > > +				NFSD_A_CONTROL_PLANE_MAX_CONN,
> > > +				nn->max_connections);
> > > +}
> > > +
> > >  /**
> > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespa=
ce
> > >   * @net: a freshly-created network namespace

--=20
Jeff Layton <jlayton@kernel.org>

