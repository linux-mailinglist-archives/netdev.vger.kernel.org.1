Return-Path: <netdev+bounces-292209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAsWHX+1FmrFpgcAu9opvQ
	(envelope-from <netdev+bounces-292209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:12:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA95E1997
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEC75302A2DB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E03E3C53;
	Wed, 27 May 2026 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="hrBRNfYp"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DF3D6CB6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872752; cv=none; b=Q36VxRq6vp9jkaQ9KzDRQw5UdwxuCXeEWg0VtPQ/0lzNB8kosEGQ1yuSNJOvCkJFL3/hrEel5BQLF4uu/R7bfn/Fw92+eyig2xP0ghdTGauOsj5HLHPU4zw1q6FdUjre9kRqOqBbPfLuMZWLsziHzuwuFKnzAHdztZU5/zUSyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872752; c=relaxed/simple;
	bh=qfsqRf6v/474IB9jMHqiCe11GPPAWUJzFdxIEsT6oeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kiy9Pv0hBVACoaqinua7u6FieJXKG//fGUrTHVCBP7B8an+zLvg5giwWYtGGdbagIO27fvgQKhTmPCC9IhsYktZrCBswjEUSuDfMIp5UwoKbky8ggZ+0C+RJzmVkEnt0MHzy0VkAWlwpaoW6MV5ANUuVGIZ0ENZhoYqpGCBU8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=hrBRNfYp; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	content-transfer-encoding:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1779872746; x=1780736747; bh=qfsq
	Rf6v/474IB9jMHqiCe11GPPAWUJzFdxIEsT6oeg=; b=hrBRNfYpgmTZgaeWY/12
	eYxY0mk4qo8JfjrZEewfLv0639w4L9DqD69BeIHnLqLT8PPUsqjTycwAAxwKsLAe
	jJGnxR3Pw5fSuL0FMXYgHJsd4zoeajpCMPpDXjAwPhqv7xtJhnG8jM1bSAGJ6/jN
	LvCYmJP9bAJg3cfvxShNGKO+jUHkN+zgSDTRSGnaw/kLvVTUe08++5E8QtosRL2b
	5uh3BeSuqZ+GJKcJimTwFVge+Vk2/a/zkmCDDmLjV8RhFaefH7BuFKSmKzBXlT1P
	Y2nuLQxMgN9oWYHKp9DqUbr8v+O0dOvWMpYEDmyIaiHFsDcy4COrA0M9h0zuI4lH
	og==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Wed, 27 May 2026 11:05:46 +0200 (CEST)
Date: Wed, 27 May 2026 11:05:43 +0200
From: Antony Antony <antony@phenome.org>
To: kuba@kernel.org
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: nipa: tree selection fails for ipsec-next series?
Message-ID: <ahaz550I55ZvMRDI@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292209-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[phenome.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,phenome.org:dkim]
X-Rspamd-Queue-Id: C1AA95E1997
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

nipa run, 1101209,  failed tree selection for my v9 series and I wanted to 
share what I found while diagnosing it. I feel this happens on patches, ipsec-next,  
too.  In the past, I ignored it. Since this patch set is  long series I 
looked deeper.

https://patchwork.kernel.org/project/netdevbpf/patch/migrate-state-v9-16-ad9947e4ae74@secunet.com/
"Guessing tree name failed - patch did not apply"

Looking at the nipa source, series_tree_name_direct() matches the cover
letter subject against _trees.keys(). Since ipsec and ipsec-next are not
in the deployed conf_trees, the match fails and nipa falls back to
guessing against net-next. I am guessing ipsec-next is missing in the config too.
Where is the config nipa runs use? I didn't find the exact config nipa bot 
used.

I also noticed that my v8 (series 1089594) was identified as
net-next — it applied to net-next at the time, which masked the issue.
v9 no longer applies to net-next, so the guessing failed visibly this
time. 

https://patchwork.kernel.org/project/netdevbpf/patch/migrate-state-v8-14-4578fb016965@secunet.com/

Any idea what could be improved? Is it because the e-mails arrive out or 
order?

Would it make sense to add ipsec and ipsec-next to nipa's [trees] config?
That way series_tree_name_direct() could match them directly from the
cover letter subject rather than falling through to guessing.

Thanks,
Antony

