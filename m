Return-Path: <netdev+bounces-231437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB055BF9374
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 791854E8F42
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77BE2BE05B;
	Tue, 21 Oct 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKyX+FMh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE171607A4;
	Tue, 21 Oct 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088931; cv=none; b=mqg56g+b5kcrMDv/SZyT8vyWgbErKil3B1nSDHjhQvHnbqOxwfqo5a2wRLJn5MzClf6NboYEzJ/OceKkV2/OHniqKH52+yYmA6Y5O3DPPsLdhax5x0zsCbASNX3M+MwxrhL+GjJOkV83hpVmDoP1Sz2+Jb+J1apVi5+wLY32TqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088931; c=relaxed/simple;
	bh=KS1gUKbzv6wVHDN+QdAU9oVbX/OCFpep//VN36feu5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U535R5s4v4jTzSdFU9mnwYUncMEMdMtTQ6aO61suhtEl9cB0SDTdBiLWrq3RajOhRwr8WAQ0sfup5Ko670ytDnNW9nq/YW0s9fn12/KMdA1VgYNlxjy7Bjm9FFzlgFNcKH8R3yJ+1b1LdVE+4EEgvmePVzyDgZIC5onywk+HfLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKyX+FMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EFAC4CEFD;
	Tue, 21 Oct 2025 23:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761088931;
	bh=KS1gUKbzv6wVHDN+QdAU9oVbX/OCFpep//VN36feu5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKyX+FMhXAZuBb9Y3AF/s++6XipsxNuhaxXq/craMh88lm7a7+GETrsCLMSmiIbjk
	 Dlh2UzbxjJDS4eKU2ECueYp771b4MN5IOuNay0TdtyDDh+FSjKFd3cUXHP3f01yudO
	 QsYWaycXwPkxiQJG2OO6iY98It7FZnZmeM5SaD7Zi/w+qMuDXd8BYmZCJ+DJXltK5h
	 F0sOV4e/y743iH0ibQfwQa/byAfbMIY0V7B8djPVg4Fh+G0cwU91r3V34s5+17RILX
	 JzAdIcdYZatVWzpOeacSPK0noV7icrYmtzCgJAbLPiUIQUbdtd46LvKOcKTUuSWbvY
	 4aoMl527JCXNw==
Date: Tue, 21 Oct 2025 16:22:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH 2/4] tools: ynl: zero-initialize struct ynl_sock memory
Message-ID: <20251021162209.73215f57@kernel.org>
In-Reply-To: <7mgcwqzafkqheqmbvkdx6bfeugfkuqrgik6ipdoxy3rtvinkqq@uxwnz7243zec>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
	<20251018151737.365485-3-zahari.doychev@linux.com>
	<20251020161639.7b1734c6@kernel.org>
	<7mgcwqzafkqheqmbvkdx6bfeugfkuqrgik6ipdoxy3rtvinkqq@uxwnz7243zec>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 20:36:38 +0300 Zahari Doychev wrote:
> On Mon, Oct 20, 2025 at 04:16:39PM -0700, Jakub Kicinski wrote:
> > On Sat, 18 Oct 2025 17:17:35 +0200 Zahari Doychev wrote:  
> > > The memory belonging to tx_buf and rx_buf in ynl_sock is not
> > > initialized after allocation. This commit ensures the entire
> > > allocated memory is set to zero.
> > > 
> > > When asan is enabled, uninitialized bytes may contain poison values.
> > > This can cause failures e.g. when doing ynl_attr_put_str then poisoned
> > > bytes appear after the null terminator. As a result, tc filter addition
> > > may fail.  
> > 
> > We add strings with the null-terminating char, AFAICT.
> > Do you mean that the poison value appears in the padding?
> >   
> 
> Yes, correct. The function nla_strcmp(...) does not match in this case as
> the poison value appears in the padding after the null byte.
> 
> > > Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> > > ---
> > >  tools/net/ynl/lib/ynl.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> > > index 2bcd781111d7..16a4815d6a49 100644
> > > --- a/tools/net/ynl/lib/ynl.c
> > > +++ b/tools/net/ynl/lib/ynl.c
> > > @@ -744,7 +744,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
> > >  	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
> > >  	if (!ys)
> > >  		return NULL;
> > > -	memset(ys, 0, sizeof(*ys));
> > > +	memset(ys, 0, sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);  
> > 
> > This is just clearing the buffer initially, it can be used for multiple
> > requests. This change is no good as is.  
> 
> I see. Should then the ynl_attr_put_str be changed to zero the padding
> bytes or it is better to make sure the buffers are cleared for each
> request?

Eek, I think the bug is in how ynl_attr_put_str() computes len.
len is attr len, it should not include padding.
At the same time we should probably zero-terminate the strings
in case kernel wants NLA_NUL_STRING.

Just for illustration -- I think we should do something like 
the following, please turn this into a real patch if it makes sense:

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 29481989ea76..515c6d12f68a 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -314,14 +314,14 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
        size_t len;
 
        len = strlen(str);
-       if (__ynl_attr_put_overflow(nlh, len))
+       if (__ynl_attr_put_overflow(nlh, len + 1))
                return;
 
        attr = (struct nlattr *)ynl_nlmsg_end_addr(nlh);
        attr->nla_type = attr_type;
 
        strcpy((char *)ynl_attr_data(attr), str);
-       attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
+       attr->nla_len = NLA_HDRLEN + len + 1;
 
        nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);

