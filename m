Return-Path: <netdev+bounces-75057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412C867F73
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FB91F27103
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7E812E1ED;
	Mon, 26 Feb 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umcXnLPr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0112E1CC
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970422; cv=none; b=pO9VXEHIVEB/1oGermJCCb9gIHefMJD4UhD/oiW5je2AlnJNYnMY87p4aQFH0zsEm+mKLezXRVCgCW7iklfnewjzzwTbvo/UO/rzrj2AkbHJNe1YjdxAiFfBqVuPtVXVLPVCg59aZDS9yXGTXTqjgG8a4CtTGfyDJAQRMuJlGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970422; c=relaxed/simple;
	bh=3cgWbsILfFUsLgfMhtdxKybF9L7xscWnZzCJILBs2xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ci8ULAWThudFrJDl9uA+4O4L2tb005TWuHTOTv9WWvVaxnnXre+EoiezR/5o+6YhFSB2aC2ezRBNDZvpwHj/ybIwW9ejUu9cjFqmuLshG4NNV0R7VYTS7qObEuQ9sEpa2m7wVoFcGWGsLemRTcUjczaJ8XbcZcfhnRN/hnWAxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umcXnLPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1CDC433F1;
	Mon, 26 Feb 2024 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708970421;
	bh=3cgWbsILfFUsLgfMhtdxKybF9L7xscWnZzCJILBs2xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umcXnLPrOCif7IFHdjK3WlpRUmIjqxuMvZvPTHsTVdfx1IhUCMBQ2O9wFfZhuZ6dR
	 9jnq7I0vQrsTCwADHaLVVibNTBtmdUblNXxMhSlBGatjThwWxUlwnsGUOuCOj1KFX9
	 Zp6mDEESS5EtFRX0AgD+89j76M42r4bncrQTBHCL/mRCjO/etTavBkKTkWNF4X0cvY
	 nyk3czMFa1slAXznyfb+4t4FcIh6RLC+h/l7tf6ez7bMZz+9j9LTrVntF3+u4VKgXt
	 kNer/kCgxehA1qcXYuzP/xGgLodIqAaGaUKhgt3GeX8CMjCh70xcszytaS8vG1CPNd
	 3Srqynog6kxtg==
Date: Mon, 26 Feb 2024 10:00:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, sdf@google.com,
 nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 00/15] tools: ynl: stop using libmnl
Message-ID: <20240226100020.2aa27e8f@kernel.org>
In-Reply-To: <m27ciroaur.fsf@gmail.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
	<20240223083440.0793cd46@kernel.org>
	<m27ciroaur.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 09:04:12 +0000 Donald Hunter wrote:
> > On Fri, 23 Feb 2024 16:26:33 +0000 Donald Hunter wrote:  
> >> Is the absence of buffer bounds checking intentional, i.e. relying on libasan?  
> >
> > In ynl.c or the generated code?  
> 
> I'm looking at ynl_attr_nest_start() and ynl_attr_put*() in ynl-priv.h
> and there's no checks for buffer overrun. It is admittedly a big
> buffer, with rx following tx, but still.

You're right. But this series isn't making it worse, AFAIU.
We weren't checking before, we aren't checking now.

I don't want to have to add another arg to all put() calls.
How about we sash the max len on nlmsg_pid?

Something like:

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 6361318e5c4c..d4ffe18b00f9 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -135,6 +135,8 @@ int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
 
 /* Netlink message handling helpers */
 
+#define YNL_MSG_OVERFLOW	1
+
 static inline struct nlmsghdr *ynl_nlmsg_put_header(void *buf)
 {
 	struct nlmsghdr *nlh = buf;
@@ -239,11 +241,26 @@ ynl_attr_first(const void *start, size_t len, size_t skip)
 	return ynl_attr_if_good(start + len, attr);
 }
 
+static inline bool
+__ynl_attr_put_overflow(struct nlmsghdr *nlh, size_t size)
+{
+	bool o;
+
+	/* We stash buffer length on nlmsg_pid. */
+	o = nlh->nlmsg_len + NLA_HDRLEN + NLMSG_ALIGN(size) > nlh->nlmsg_pid;
+	if (o)
+		nlh->nlmsg_pid = YNL_MSG_OVERFLOW;
+	return o;
+}
+
 static inline struct nlattr *
 ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
 {
 	struct nlattr *attr;
 
+	if (__ynl_attr_put_overflow(nlh, 0))
+		return ynl_nlmsg_end_addr(nlh) - NLA_HDRLEN;
+
 	attr = ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type | NLA_F_NESTED;
 	nlh->nlmsg_len += NLMSG_ALIGN(sizeof(struct nlattr));
@@ -263,6 +280,9 @@ ynl_attr_put(struct nlmsghdr *nlh, unsigned int attr_type,
 {
 	struct nlattr *attr;
 
+	if (__ynl_attr_put_overflow(nlh, size))
+		return;
+
 	attr = ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type;
 	attr->nla_len = NLA_HDRLEN + size;
@@ -276,14 +296,17 @@ static inline void
 ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
 {
 	struct nlattr *attr;
-	const char *end;
+	size_t len;
+
+	len = strlen(str);
+	if (__ynl_attr_put_overflow(nlh, len))
+		return;
 
 	attr = ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type;
 
-	end = stpcpy(ynl_attr_data(attr), str);
-	attr->nla_len =
-		NLA_HDRLEN + NLA_ALIGN(end - (char *)ynl_attr_data(attr));
+	strcpy(ynl_attr_data(attr), str);
+	attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
 
 	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
 }
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 86729119e1ef..c2ba72f68028 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -404,9 +404,33 @@ struct nlmsghdr *ynl_msg_start(struct ynl_sock *ys, __u32 id, __u16 flags)
 	nlh->nlmsg_flags = flags;
 	nlh->nlmsg_seq = ++ys->seq;
 
+	/* This is a local YNL hack for length checking, we put the buffer
+	 * length in nlmsg_pid, since messages sent to the kernel always use
+	 * PID 0. Message needs to be terminated with ynl_msg_end().
+	 */
+	nlh->nlmsg_pid = YNL_SOCKET_BUFFER_SIZE;
+
 	return nlh;
 }
 
+static int ynl_msg_end(struct ynl_sock *ys, struct nlmsghdr *nlh)
+{
+	/* We stash buffer length on nlmsg_pid */
+	if (nlh->nlmsg_pid == 0) {
+		yerr(ys, YNL_ERROR_INPUT_INVALID,
+		     "Unknwon input buffer lenght");
+		return -EINVAL;
+	}
+	if (nlh->nlmsg_pid == YNL_MSG_OVERFLOW) {
+		yerr(ys, YNL_ERROR_INPUT_TOO_BIG,
+		     "Constructred message longer than internal buffer");
+		return -EMSGSIZE;
+	}
+
+	nlh->nlmsg_pid = 0;
+	return 0;
+}
+
 struct nlmsghdr *
 ynl_gemsg_start(struct ynl_sock *ys, __u32 id, __u16 flags,
 		__u8 cmd, __u8 version)
@@ -606,6 +630,10 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
 	nlh = ynl_gemsg_start_req(ys, GENL_ID_CTRL, CTRL_CMD_GETFAMILY, 1);
 	ynl_attr_put_str(nlh, CTRL_ATTR_FAMILY_NAME, family_name);
 
+	err = ynl_msg_end(ys, nlh);
+	if (err < 0)
+		return err;
+
 	err = send(ys->socket, nlh, nlh->nlmsg_len, 0);
 	if (err < 0) {
 		perr(ys, "failed to request socket family info");
@@ -867,6 +895,10 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 {
 	int err;
 
+	err = ynl_msg_end(ys, req_nlh);
+	if (err < 0)
+		return err;
+
 	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
 	if (err < 0)
 		return err;
@@ -920,6 +952,10 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 {
 	int err;
 
+	err = ynl_msg_end(ys, req_nlh);
+	if (err < 0)
+		return err;
+
 	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
 	if (err < 0)
 		return err;
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index dbeeef8ce91a..9842e85a8c57 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -20,6 +20,8 @@ enum ynl_error_code {
 	YNL_ERROR_ATTR_INVALID,
 	YNL_ERROR_UNKNOWN_NTF,
 	YNL_ERROR_INV_RESP,
+	YNL_ERROR_INPUT_INVALID,
+	YNL_ERROR_INPUT_TOO_BIG,
 };
 
 /**
-- 
2.43.2


