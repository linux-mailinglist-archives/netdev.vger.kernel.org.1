Return-Path: <netdev+bounces-166855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B074FA37922
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 01:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C981668AB
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8775E372;
	Mon, 17 Feb 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ayto.laspalmasgc.es header.i=@ayto.laspalmasgc.es header.b="WlWX8DDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.laspalmasgc.es (unknown [195.57.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142363FF1
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.57.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739751246; cv=none; b=Y9proBWMwjrHKCALXHCmXn5ISDqTcFZXfUUoL7/+A9ziNHlxXW5lsAGL1qDIhIAp+mpUXqPCBJujPhla2ULkPe2yuVgqynrRyryh3CCbiwYSfm8ISrWx5w5W4LhM21JT/17DEXVEs5by8wNP/7K3SwpZ22P9ExFyC8SA6Z51BWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739751246; c=relaxed/simple;
	bh=yVMgM6hRWJLcId0f3u09Rkf1e73CRvPu7hyq5z5cPuY=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=TUe1t6Wr6RkeJweE+i71ZHvScBQchTKss8baROske6rqtm8wi2IF73gfDkZyOMYP+bJb7ass3zkyEHgzLXf07F+/nZqAGYROo4ERLVgLjcFNXzVPP0vo2jyfiqsmDs0kVzaiZlX6gwVQS8nAS+SnHkBtzXp02osnmdewhlwUxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayto.laspalmasgc.es; spf=pass smtp.mailfrom=ayto.laspalmasgc.es; dkim=pass (1024-bit key) header.d=ayto.laspalmasgc.es header.i=@ayto.laspalmasgc.es header.b=WlWX8DDZ; arc=none smtp.client-ip=195.57.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayto.laspalmasgc.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ayto.laspalmasgc.es
Received: from mail.laspalmasgc.es (localhost [127.0.0.1])
	by mail.laspalmasgc.es (Postfix) with ESMTPS id 400BE4A21B38
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 20:11:20 +0000 (WET)
Received: from localhost (localhost [127.0.0.1])
	by mail.laspalmasgc.es (Postfix) with ESMTP id 8D2804A010F3
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 19:46:00 +0000 (WET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.laspalmasgc.es 8D2804A010F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ayto.laspalmasgc.es;
	s=B5DA726C-EE3B-11EC-822D-11D2D27EF842; t=1739735160;
	bh=yVMgM6hRWJLcId0f3u09Rkf1e73CRvPu7hyq5z5cPuY=;
	h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:
	 Content-Type;
	b=WlWX8DDZ+RLKbBDr5hsIU4P0geTlR9UcZooo8zZb7jJmJI8aFpP1yhFSdrWjX7PqQ
	 jQ8IqTIo0deHBGcArO3NjmRYKS1ra+3ZQ6jLxfISNyJbOS3/BIOge16LAixzLzGbFF
	 U6FtB0iCOZzAk58hV1FQxCUYDyS9YgAPK4UkDzns=
Received: from mail.laspalmasgc.es ([127.0.0.1])
	by localhost (mail.laspalmasgc.es [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yppA_KCQ3phD for <netdev@vger.kernel.org>;
	Sun, 16 Feb 2025 19:46:00 +0000 (WET)
Received: from mail.laspalmasgc.es (localhost [127.0.0.1])
	by mail.laspalmasgc.es (Postfix) with ESMTP id 7CA574A010DF
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 19:46:00 +0000 (WET)
Date: Sun, 16 Feb 2025 19:46:00 +0000 (WET)
From: Anna <38798@ayto.laspalmasgc.es>
Reply-To: anna@masterautorepair.onmicrosoft.com
To: netdev@vger.kernel.org
Message-ID: <1675307806.8417602.1739735160442.JavaMail.zimbra@ayto.laspalmasgc.es>
Subject: Return Filing Services Inquiry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8417601_703970933.1739735160441"
X-Mailer: Zimbra 8.6.0_GA_1241
Thread-Topic: Return Filing Services Inquiry
Thread-Index: pXsy2lXRqKzCO+ttcUqd/UXZSR1dtA==

------=_Part_8417601_703970933.1739735160441
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,



I hope you're doing well. I wanted to inquire whether you are currently accepting new clients for individual tax return filing for the current tax year.



My husband and I filed jointly for the 2023 tax year. Our names are James and Anna Edwards, and we both work as travel therapists in the medical field, which requires us to relocate frequently. We came across your contact information while searching through an online directory.



Please let me know if you would like us to provide our tax organizer, personal statement, and relevant documents, including our W-2s, some 1040 details, and 1099 forms.



Looking forward to your response.



Best regards,
Anna.
------=_Part_8417601_703970933.1739735160441--

