Return-Path: <netdev+bounces-122493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871ED961825
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222931F235B6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4C823DF;
	Tue, 27 Aug 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTYz5Lmt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F419473;
	Tue, 27 Aug 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788015; cv=none; b=ehEzI5NcAO/tCkOKPycnfG1aoqO74F77Na7aJxh9bNmwO4yFEomHbJ75yEd8jvsUwBc5R7NZMk8vOKkhtrrif18tbCGexBsLzr39AxLFTfjKXyL27PkvxnZm6NvA1MekWcaCH8Vj1vCzaAfNrMDH6A/hN8pF3TDfaDOJGJDK/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788015; c=relaxed/simple;
	bh=6yJLN0XpC0DVdiG5+8XJxsuS2o7iYALkBPYyjPB2Hro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pM8Bl7wW69/Y5teJi4XZqVs7S1AtS+OSz14fsUj9ZM5K5/ewtXPOESeexDXqKoXC/Gp0zl7eYfRabk9ZcpqnA4YNzVjii+s05oIw2aX+Gcbzff/tZZy1QA+k/F3rWyRVdEfhRRD2XgSyjDfcjUkM3pRBpSkLmPZdEhi856CtwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTYz5Lmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F75C4FDF1;
	Tue, 27 Aug 2024 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724788015;
	bh=6yJLN0XpC0DVdiG5+8XJxsuS2o7iYALkBPYyjPB2Hro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTYz5LmttVKPJu+TjnM0Wgpq/50k1g0UjcDYvyZmka4VVbvVRbUSjdGOkP5FLsIay
	 HMlIwnXdgITqEcW/NlZg6eRegsFOmjpaJ4svoURUYCSGazo5XCwfz6ymjxuyzHk3yN
	 2ky9J5B9l19kh12cpdFoILWMvWmIEEQWM4fkCiC8+FhsWZE/hUH1IT8evQNuNRNAtd
	 F8zcbqkp29i25AjyahIdwrIfpOkVzqnapv3nOBE8Ju3zMk11BqRFJZkR6bO6yVV+U3
	 9Z8mt7RrRxbsc05M/9tCUXJZegYwNcwO7od2HXRdXXqQ4HHqveIyiSvKWbsGHikG0r
	 Q3qW5LByEUCaA==
Date: Tue, 27 Aug 2024 12:46:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v3] net: ethtool: fix unheld rtnl lock
Message-ID: <20240827124653.51cf9789@kernel.org>
In-Reply-To: <20240827092336.16adeee3@fedora-3.home>
References: <20240826130712.91391-1-djahchankoike@gmail.com>
	<20240826173913.7763-1-djahchankoike@gmail.com>
	<20240827092336.16adeee3@fedora-3.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 09:23:36 +0200 Maxime Chevallier wrote:
> On Mon, 26 Aug 2024 14:38:53 -0300
> Diogo Jahchan Koike <djahchankoike@gmail.com> wrote:
> 
> > ethnl_req_get_phydev should be called with rtnl lock held.
> > 
> > Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
> > Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
> > Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>  
> 
> This looks good to me.
> 
> Even though RTNL is released between the .validate() and .set()
> calls, should the PHY disappear, the .set() callback handles that. 
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I know this isn't very well documented, but the point of .set_validate
is to perform checks before taking rtnl_lock (which may be quite
heavily contended), and potentially skip .set completely.
See 99132b6eb792 ("ethtool: netlink: handle SET intro/outro in the
common code"). Since we take rtnl lock and always return 1, this starts
to feel a bit cart before the horse.

How about we move the validation into set? (following code for
illustration only, please modify/test/review carefully and submit
as v4 if agreed on):

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index ff81aa749784..18759d8f85a5 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -217,13 +217,10 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 };
 
 static int
-ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
+ethnl_set_pse_validate(struct phy_device *phydev, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
-	struct phy_device *phydev;
 
-	phydev = dev->phydev;
 	if (!phydev) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
 		return -EOPNOTSUPP;
@@ -249,7 +246,7 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 	}
 
-	return 1;
+	return 0;
 }
 
 static int
@@ -258,10 +255,14 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
-	int ret = 0;
+	int ret;
 
 	phydev = dev->phydev;
 
+	ret = ethnl_set_pse_validate(phydev, info);
+	if (ret)
+		return ret;
+
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
 		unsigned int pw_limit;
 
@@ -307,7 +308,6 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
 	.fill_reply		= pse_fill_reply,
 	.cleanup_data		= pse_cleanup_data,
 
-	.set_validate		= ethnl_set_pse_validate,
 	.set			= ethnl_set_pse,
 	/* PSE has no notification */
 };

