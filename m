Return-Path: <netdev+bounces-62752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B83828F13
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 22:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE124B2591B
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7963446D8;
	Tue,  9 Jan 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfrJmHGJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B700446D5;
	Tue,  9 Jan 2024 21:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA90C433F1;
	Tue,  9 Jan 2024 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836454;
	bh=tmKahUUY9q5zoJxNhU6LVASBckJNzOCwH7UKYk7KN+0=;
	h=Date:From:To:Subject:From;
	b=ZfrJmHGJ3wxEjWXd3JNM2zZI0btOCGKzL3yT7uNsghT05S+G7xlzebtbGCoagW/eV
	 10arAzhAj4M29EpJ7o7e4fkGWV9SXc/4aD/3QhmZqY/8Ly1dXdt7UyyIoj9v1nWYTg
	 ukpTvCO0VC39bGl8UjLJvHsE2LlXmGDw0Bu5nM6A0FqvK1Nr2obtvq7JOAydamQD3L
	 m78GbrokwSX+PeBgoa30iIVh8fnGteeZ2r6Z19E9ZSzUj7L5jKI5qxtrvuCyUtJ38H
	 wgKi7fqIPZ1w1gdQD0WYlINH0xFdAZ9CJx9xvSqVYWqRLkbh6lmVySzILrFnYGl+iS
	 Cj/PVdpVOEFCw==
Date: Tue, 9 Jan 2024 13:40:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.8
Message-ID: <20240109134053.33d317dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Intro
-----

We have posted our pull requests with networking changes for the 6.8
kernel release earlier today. As is tradition here are the development
statistics based on mailing list traffic on netdev@vger.

These stats are somewhat like LWN stats:
https://lwn.net/Articles/956765/
but more focused on review participation.

Changes in methodology
----------------------

After a few releases of laziness, I took a day to work on the code.
First and perhaps most importantly I added workarounds to the code
grouping emails into threads. 3% of emails which would previously 
not get threaded now does, which should help reviewer scores.

I also implemented a fairly naive "change set tracking".
Scripts can group threads with the same subject (minus stuff in square
brackets) into a "change set". Detect when review tags are sent on
the list, anywhere in the life cycle of the change set. As well as
when the change set gets applied (by finding patchwork bot's reply).
This is all a bit wobbly, as we only analyze traffic from one release
cycle (patches may have been posted for the previous cycle already),
patchwork bot doesn't always reply, and cover letters change subject.
Hopefully those inaccuracies don't muddy up the picture too much :)

The change sets factor into the score math, the new formula is:

   2 * change-set-reviewer 
 + 8 * thread-reviewer
 + 2 * (msg-reviewer - 1)
 - 4 * msg-author

General stats
-------------

Cycle started on Fri, 27 Oct, ended Tue, 09 Jan. That's 74 days
(with a slight overlap with previous cycle, I computed previous
stats few days after the PR, it seems). That's 11 days more
than previous cycle.

We have seen 240 msg/day on the list, and 17 commits/day.
The commits dropped by 12%, which is not very surprising given 
the winter break.

The number of review tags in git history have recovered to 69% total
commits containing review tags and 54% with tags from different company
than the author.

Change set stats
----------------

Review rate from git history match the results from the new change set
logic. According to the change set stats - 66% of "change sets" which
ended up getting applied had replies carrying Review / Ack tags.

Change sets which got applied without any review tag posted to the list
had on average 1.35 revisions, those which did receive review tags had
1.80 revisions.

Another somewhat interesting stat is that single-patch postings
had on average 1.40 revisions, while multi-patch series 2.17.
Which makes sense, as bug in any patch requires a repost of the whole
series.

Longest change set (most revisions) the script was able to track down
in this cycle had 10 postings.

Rankings
--------

In next release cycle I'll switch some of the rankings to change sets,
if they are more interesting. Since I don't have "previous ranking"
for change sets this time I'm sticking to threads and messages.

Top reviewers (thr):                 Top reviewers (msg):                
   1 ( +1) [24] Jakub Kicinski          1 (   ) [43] Jakub Kicinski      
   2 ( -1) [23] Simon Horman            2 (   ) [39] Simon Horman        
   3 (   ) [15] Andrew Lunn             3 (   ) [39] Andrew Lunn         
   4 ( +1) [10] Eric Dumazet            4 ( +6) [23] Vladimir Oltean     
   5 ( +6) [ 8] Russell King            5 ( -1) [19] Eric Dumazet        
   6 ( -2) [ 7] Paolo Abeni             6 ( +7) [17] Russell King 
   7 ( +6) [ 5] Vladimir Oltean         7 ( +1) [15] Jiri Pirko  
   8 (   ) [ 5] Jiri Pirko              8 (+13) [11] Krzysztof Kozlowski 
   9 ( -3) [ 5] David Ahern             9 ( -3) [10] Paolo Abeni         
  10 (+13) [ 5] Krzysztof Kozlowski    10 ( -5) [ 9] David Ahern         
  11 ( +1) [ 4] Willem de Bruijn       11 (***) [ 8] Sergey Shtylyov     
  12 ( +9) [ 3] Stephen Hemminger      12 ( +3) [ 7] Willem de Bruijn    
  13 ( -4) [ 3] Florian Fainelli       13 ( -6) [ 7] Florian Fainelli    
  14 (   ) [ 3] Rob Herring            14 (+19) [ 6] Stephen Hemminger   
  15 ( +1) [ 3] Przemek Kitszel        15 (+12) [ 6] Jamal Hadi Salim

Quite a bit of movement in top reviewers. All familiar names.
Thank you all for your work!

Top authors (thr):                   Top authors (msg):                  
   1 ( +2) [5] Jakub Kicinski           1 ( +1) [22] David Howells       
   2 (+22) [5] Christian Marangi        2 (+43) [22] Christian Marangi   
   3 ( -1) [3] Eric Dumazet             3 (***) [17] Hangbin Liu         
   4 ( +1) [3] Tony Nguyen              4 (   ) [14] Saeed Mahameed      
   5 (+22) [2] Shinas Rasheed           5 ( +4) [14] Tony Nguyen         
   6 (***) [2] Heiner Kallweit          6 (+19) [12] Kuniyuki Iwashima   
   7 (***) [2] Suman Ghosh              7 (   ) [11] Jakub Kicinski      
   8 (+11) [2] Stephen Rothwell         8 ( +8) [11] Andrii Nakryiko     
   9 (+14) [2] Kuniyuki Iwashima        9 (***) [10] Claudiu Beznea      
  10 (+34) [2] Hangbin Liu             10 (+26) [10] Justin Lai          

Christian contributed a lot of (versions of? ;) PHY changes
and LED integrations. Hangbin Liu significantly improved 
the selftests. Shinas posts the octeon EP VF driver.
Kuniyuki contributed to the socket layer (bhash2, 
TCP syn cookies, UNIX sockets).

Top reviewers (thr):                 Top reviewers (msg):                
   1 (   ) [38] RedHat                  1 (   ) [76] RedHat              
   2 (   ) [28] Meta                    2 (   ) [56] Meta                
   3 (   ) [19] Intel                   3 ( +1) [39] Andrew Lunn         
   4 ( +2) [15] Andrew Lunn             4 ( -1) [38] Intel               
   5 ( -1) [14] Google                  5 (   ) [31] Google              
   6 ( +5) [ 9] Oracle                  6 ( +6) [23] NXP                 
   7 ( +2) [ 9] Linaro                  7 ( -1) [23] nVidia              

Top authors (thr):                   Top authors (msg):                  
   1 ( +1) [18] Intel                   1 (   ) [67] Intel               
   2 ( +1) [12] RedHat                  2 ( +1) [60] RedHat              
   3 ( -2) [10] Google                  3 ( -1) [48] nVidia              
   4 (   ) [ 9] Meta                    4 ( +1) [32] Meta                
   5 ( +4) [ 7] Marvell                 5 ( -1) [24] Google              
   6 ( -1) [ 7] nVidia                  6 ( +4) [22] Alibaba             
   7 (+22) [ 5] Christian Marangi       7 (+23) [22] Christian Marangi   

Top scores (positive):               Top scores (negative):              
   1 (   ) [277] RedHat                 1 (+20) [81] Christian Marangi   
   2 (   ) [250] Meta                   2 ( +3) [73] Alibaba             
   3 (   ) [219] Andrew Lunn            3 ( -1) [67] nVidia              
   4 ( +4) [111] Oracle                 4 ( +9) [54] Marvell             
   5 (+34) [100] Google                 5 (+32) [50] Qualcomm            
   6 ( +4) [ 82] Linaro                 6 (***) [44] Amazon              
   7 ( +7) [ 70] NXP                    7 ( +4) [43] RealTek             
   8 ( -4) [ 62] Enfabrica              8 ( -7) [41] Bootlin             
   9 ( -2) [ 45] ARM                    9 (***) [40] Claudiu Beznea      
  10 (+13) [ 35] Microsoft             10 ( +4) [33] Mojatatu            

Alibaba works on both virtio and SMC without contributing many reviews.
Marvell folks (Suman in particular) have started commenting on patches,
but not nearly enough to balance the volume of authorship. Qualcomm
posted PHY patches, the volume isn't huge, but there are almost no
reviews coming from them.

Histograms
----------

LWN stats for 6.7 [1] included "longevity histograms", we are also
collecting those since 6.4 [2]. Histograms don't change much so I don't
normally include them. This time, in the interest of comparison here
they are, again:

Tenure for author
 0- 1yr   |  79 | ###################################
 1- 2yr   |  41 | ##################
 2- 3yr   |  32 | ##############
 3- 4yr   |  15 | ######
 4- 5yr   |  25 | ###########
 5- 6yr   |  22 | #########
 6- 7yr   |  24 | ##########
 7- 8yr   |  13 | #####
 8- 9yr   |  19 | ########
 9-10yr   |  18 | ########
10-11yr   |  14 | ######
11-12yr   |  12 | #####
12-13yr   |  11 | ####
13-14yr   |  14 | ######
14-15yr   |  12 | #####
15-16yr   |  11 | ####
16-17yr   |  10 | ####
17-18yr   |  12 | #####
18-19yr   |  32 | ##############
19-20yr   |   8 | ###

Very similar shape to LWN/global histogram. The main difference is that
our "OG peak" at 19 years is larger in proportion to most recent year.

The histogram for reviewers does not share the initial peak:

Tenure for reviewer
 0- 1yr   |  16 | ########
 1- 2yr   |  20 | ##########
 2- 3yr   |  19 | #########
 3- 4yr   |  14 | #######
 4- 5yr   |  25 | #############
 5- 6yr   |  27 | ##############
 6- 7yr   |  25 | #############
 7- 8yr   |  18 | #########
 8- 9yr   |  25 | #############
 9-10yr   |  17 | ########
10-11yr   |  16 | ########
11-12yr   |  11 | #####
12-13yr   |  17 | ########
13-14yr   |  23 | ###########
14-15yr   |  19 | #########
15-16yr   |   9 | ####
16-17yr   |  17 | ########
17-18yr   |  19 | #########
18-19yr   |  54 | ############################
19-20yr   |  18 | #########

[1] https://lwn.net/Articles/956765/
[2] https://lore.kernel.org/all/20230428135717.0ba5dc81@kernel.org/
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.8/stdout

